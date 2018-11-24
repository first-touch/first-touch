module V1
  module User
    class Register < Trailblazer::Operation
      # TODO: Should guarantee that there is no user logged in
      step Model(::User, :new)
      step :setup_model!
      step :setup_club!
      step :claim_account!
      step Trailblazer::Operation::Contract::Build(
        constant: User::Contract::Register
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      private

      def setup_model!(options, params:, **)
        options[:model].add_role params[:role_name]
      end

      def setup_club!(options, params:, **)
        return true unless params[:club_id]
        club = ::Club.find(params[:club_id])
        options[:model].clubs = [club]
      end

      def claim_account!(options, **)
        options[:model].unclaimed = false
        true
      end
    end
  end
end
