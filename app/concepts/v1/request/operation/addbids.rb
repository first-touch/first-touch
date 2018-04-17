module V1
  module Request
    class AddBids < Trailblazer::Operation
      step Model(::RequestBid, :new)
      step :find_request!
      failure :model_not_found!, fail_fast: true
      step :authorized!
      failure :unauthenticated, fail_fast: true
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Request::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def find_request!(options, params:, current_user:, **)
        options['model'].request = ::Request.all.where status: 'publish', id: params[:request_id]
      end

      def setup_model!(model:, current_user:, **)
        model.user = current_user
      end

      def authorized!(current_user:, **)
        current_user.scout?
      end
    end
  end
end
