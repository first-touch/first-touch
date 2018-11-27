module V1
  module Club
    class Update < Trailblazer::Operation
      step Model(::Club, :find_by)
      failure :model_not_found!, fail_fast: true
      step :find_account_owner!
      step Trailblazer::Operation::Contract::Build(
        constant: Club::Contract::Update
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def find_account_owner!(_opts, params:, **)
        account_owner = ::User.find_by id: params['user_id']
        params[:account_owner] = account_owner
        true
      end
    end
  end
end
