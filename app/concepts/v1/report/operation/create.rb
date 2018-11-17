module V1
  module Report
    class Create < FirstTouch::Operation
      step :authorized!
      failure :unauthorized!, fail_fast: true
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

      def model!(options, params:,  **)
        model = nil
        if !params[:job_id].blank?
          request = ::Request.find(params[:job_id])
          options['position'] = request.type_request == 'position'
          if !options['position']
            model = ::Report.find_by user_id: options[:current_user].id, completion_status: ['pending'], request_id: params[:job_id]
            params[:meta_data]['search'] = request.meta_data['search'] if request.meta_data['search']
          else
            model = ::Report.new
            model.request_id = request.id
          end
        else
          model = ::Report.new
        end
        options[:model] = model
      end

      def setup_model!(options, **)
        if options['bid']
          unless options['position']
            request = options[:model].request
            options[:model].team = request.team
            options[:model].player = request.player
            options[:model].league = request.league
          end
        else
          stripe_ft = options[:current_user].stripe_ft
          if stripe_ft.nil? || stripe_ft.preferred_account.nil?
            options[:model].price = {
              value: 0,
              currency: 0
            }
          end
        end
        options[:model].completion_status = 'complete'
        options[:model].user = options[:current_user]
      end

      def authorized!(options, **)
        options[:current_user].scout?
      end

      def stripe(options, params:, **)
        success = true
        unless params[:job_id].blank?
          stripe_ft = options[:current_user].stripe_ft
          success = false if stripe_ft.nil? || stripe_ft.preferred_account.nil?
        end
        options['stripe.errors'] = I18n.t 'no_bank_account' unless success
        success
      end

      def is_a_bid?(options, params:, **)
        success = true
        unless params[:job_id].blank?
          bid = ::RequestBid.find_by request_id: params[:job_id], user_id: options[:current_user].id, status: %w[accepted joblist]
          options['bid'] = bid
          success = !bid.blank?
        end
        success
      end

      def persist_bid(options, **)
        if options['bid']
          bid = options['bid']
          bid.status = 'completed'
          bid.report_id = options[:model].id
          bid.save
        end
        true
      end

      def send_money(options, **)
        if options['bid']
          if options['bid'].request.type_request != 'position'
            order_params = {
              'bid_id' => options['bid'].id,
              'user' => options[:model].user,
              'report_id' => options[:model].id
            }
            result = ::V1::Order::SendMoney.(
              params: order_params,
              user_id: options['bid'].user_id,
              current_user: options[:current_user]
            )
            return result.success?
          end
        end
        true
      end

      def persist_files!(options, params:,  **)
        return true if params[:files].blank?
        params[:files].each do |file|
          file_params = { url: file[:url], filename: file[:filename], report: model }
          ::V1::Attachment::Create.(params: file_params, current_user: options[:current_user])
        end
        true
      end
    end
  end
end
