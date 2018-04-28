module V1
  module Request
    class AddBids < FirstTouch::Operation
      step Model(::RequestBid, :new)
      step :authorized!
      failure :unauthenticated, fail_fast: true
      step :find_request!
      failure :model_not_found!, fail_fast: true
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: ::V1::RequestBid::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def find_request!(options, params:, current_user:, **)
        request = ::Request.all.where(status: 'publish', id: params[:id])
        options['model'].request = (request.blank?)? nil: request.first
        options['model.class'] = ::RequestBid
        options['model'].request
      end

      def setup_model!(model:, current_user:, **)
        model.user = current_user
        model.status = model.request.type_request == 'position'? 'joblist' : 'pending'
      end

      def authorized!(current_user:, **)
        current_user.scout?
      end
    end
  end
end
