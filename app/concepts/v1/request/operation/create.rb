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

      def setup_model!(model:, current_club:, **)
        model.club = current_club
      end

      def authorized!(current_club:, **)
        !current_club.nil?
      end
    end
  end
end
