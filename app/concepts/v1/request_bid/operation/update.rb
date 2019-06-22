module V1
  module RequestBid
    class Update < FirstTouch::Operation
      step Model(::RequestBid, :find_by)
      failure :model_not_found!, fail_fast: true
      step :validate_resource_ownership!
      failure :model_not_found!, fail_fast: true
      step Trailblazer::Operation::Contract::Build(
        constant: RequestBid::Contract::Update
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      private

      def validate_resource_ownership!(_opts, model:, current_user:, **)
        model.user_id == current_user.id
      end
    end
  end
end
