module V1
  module Report
    class Create < FirstTouch::Operation
      step Model(::Report, :new)
      step :authorized!
      failure :unauthenticated, fail_fast: true
      step :stripe
      failure :stripe_account_not_found!, fail_fast: true
      step :setup_model!
      step :is_a_bid?
      failure :bid_not_found!, fail_fast: true
      step Trailblazer::Operation::Contract::Build(
        constant: Report::Contract::Create
        )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
      step :send_money
      step :persist_bid

      def setup_model!(model:, current_user:, **)
        model.user = current_user
      end

      def authorized!(current_user:, **)
        current_user.scout?
      end

      def is_a_bid?(options, model:,params:, current_user:, **)
        if !params[:job_id].blank?
          bid = ::RequestBid.find_by request_id: params[:job_id], user_id: current_user.id, status: ['accepted','joblist']
          options['bid'] = bid
          !bid.blank?
        else
          true
        end
      end

      def persist_bid(options, model:, params:, current_user:, **)
        if options['bid']
          bid =  options['bid']
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
            result = ::V1::Order::SendMoney.(order_params, user_id: options['bid'].user_id )
            return result.success?
          end
        end
        true
      end

    end
  end
end
