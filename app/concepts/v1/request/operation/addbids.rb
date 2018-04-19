module V1
  module Request
    class AddBids < Trailblazer::Operation
      step Model(::RequestBid, :new)
      step :authorized!
      failure :unauthenticated, fail_fast: true
      step :find_request!
      failure :model_not_found!, fail_fast: true
      step :logic
      failure :model_not_found!, fail_fast: true
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: RequestBids::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def find_request!(options, params:, current_user:, **)
        request = ::Request.all.where(status: 'publish', id: params[:id])
        options['model'].request = (request.blank?)? nil: request.first
        options['model.class'] = ::RequestBid
        options['model'].request
      end

      def logic(options, params:, current_user:, **)
        params[:price].to_i >= options['model'].request.price['value'] and params[:price].to_i <= options['model'].request.price['max']
      end

      def setup_model!(model:, current_user:, **)
        model.user = current_user
        model.status = 'pending'
      end

      def authorized!(current_user:, **)
        current_user.scout?
      end
    end
  end
end
