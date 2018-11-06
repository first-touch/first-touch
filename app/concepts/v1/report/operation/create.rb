module V1
  module Report
    class Create < FirstTouch::Operation
      step :authorized!
      failure :unauthorized, fail_fast: true
      step :model!
      step :stripe
      failure :stripe_account_not_found!, fail_fast: true
      step :is_a_bid?
      failure :bid_not_found!, fail_fast: true
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Report::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
      step :persist_files!
      step :send_money
      step :persist_bid

      def model!(options, params:, current_user:, **)
        model = nil
        if !params[:job_id].blank?
          request = ::Request.find(params[:job_id])
          options['position'] = request.type_request == 'position'
          if !options['position']
            model = ::Report.find_by user_id: current_user.id, completion_status: ['pending'], request_id: params[:job_id]
            params[:meta_data]['search'] = request.meta_data['search'] if request.meta_data['search']
          else
            model = ::Report.new
            model.request_id = request.id
          end
        else
          model = ::Report.new
        end
        options['model'] = model
      end

      def setup_model!(options, model:, current_user:, **)
        if options['bid']
          unless options['position']
            request = model.request
            model.team = request.team
            model.player = request.player
            model.league = request.league
          end
        else
          stripe_ft = current_user.stripe_ft
          if stripe_ft.nil? || stripe_ft.preferred_account.nil?
            model.price = {
              value: 0,
              currency: 0
            }
          end
        end
        model.completion_status = 'complete'
        model.user = current_user
      end

      def authorized!(current_user:, **)
        current_user.scout?
      end

      def stripe(params:, current_user:, **)
        success = true
        unless params[:job_id].blank?
          stripe_ft = current_user.stripe_ft
          success = false if stripe_ft.nil? || stripe_ft.preferred_account.nil?
        end
        options['stripe.errors'] = I18n.t 'no_bank_account' unless success
        success
      end

      def is_a_bid?(options, model:, params:, current_user:, **)
        success = true
        unless params[:job_id].blank?
          bid = ::RequestBid.find_by request_id: params[:job_id], user_id: current_user.id, status: %w[accepted joblist]
          options['bid'] = bid
          success = !bid.blank?
        end
        success
      end

      def persist_bid(options, model:, params:, current_user:, **)
        if options['bid']
          bid = options['bid']
          bid.status = 'completed'
          bid.report_id = model.id
          bid.save
        end
        true
      end

      def send_money(options, model:, params:, current_user:, **)
        if options['bid']
          if options['bid'].request.type_request != 'position'
            order_params = {
              'bid_id' => options['bid'].id,
              'user' => model.user,
              'report_id' => model.id
            }
            result = ::V1::Order::SendMoney.(params: order_params, user_id: options['bid'].user_id, current_user: current_user)
            return result.success?
          end
        end
        true
      end

      def persist_files!(model:, params:, current_user:, **)
        params[:files].each do |file|
          file_params = { url: file[:url], filename: file[:filename], report: model }
          result = ::V1::Attachment::Create.(params: file_params, current_user: current_user)
        end
        true
      end
    end
  end
end
