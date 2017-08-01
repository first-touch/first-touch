require_relative '../../user/contract/register'

class Users
  class Register < Trailblazer::Operation
    # TODO: Should guarantee that there is no user logged in
    step Model(User, :new)
    step :setup_model!
    step :claim_account!
    step Contract::Build(constant: User::Contract::Register)
    step Contract::Validate()
    step Contract::Persist()

    private

    def setup_model!(model:, **)
      model.personal_profile = PersonalProfile.new
    end

    def claim_account!(options, **)
      options['model'].unclaimed = false
      true
    end
  end
end
