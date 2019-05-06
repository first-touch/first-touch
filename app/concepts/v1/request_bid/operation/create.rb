module V1
  module RequestBid
    class Create < FirstTouch::Operation
      step Model(::RequestBid, :new)
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: ::V1::RequestBid::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def setup_model!(_opts, params:, model:, current_user:, **)
        model.request = ::Request.find_by(id: params[:request_id])
        model.user = current_user
        model.status = 'pending'
      end
    end
  end
end
