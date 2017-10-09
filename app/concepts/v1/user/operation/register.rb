module V1
  module User
    class Register < Trailblazer::Operation
      # TODO: Should guarantee that there is no user logged in
      step Model(::User, :new)
      step :setup_model!
      step :claim_account!
      step Trailblazer::Operation::Contract::Build(
        constant: User::Contract::Register
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      private

      def setup_model!(model:, **)
        model.personal_profile = ::PersonalProfile.new
      end

      def claim_account!(options, **)
        options['model'].unclaimed = false
        true
      end
    end
  end
end
