module V1
  module Club
    class Create < Trailblazer::Operation
      step Model(::Club, :new)
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Club::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def setup_model!(options, params:, **)
        owner_id = params[:account_owner_id]
        account_owner = ::User.find_by id: owner_id
        options[:model].account_owner = account_owner
        true
      end
    end
  end
end
