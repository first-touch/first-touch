module V1
  module Request
    class Create < Trailblazer::Operation
      step Model(::Request, :new)
      step :authorized!
      failure :unauthenticated, fail_fast: true
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Request::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def setup_model!(model:, current_user:, **)
        model.user = current_user
      end

      def authorized!(current_club:, **)
        # TODO: CLUB not current_user
        !current_club.nil? || true
      end
    end
  end
end
