module V1
  module Request
    class Create < Trailblazer::Operation
      step Model(::Request, :new)
      #step :authorized!
      #failure :unauthenticated, fail_fast: true
      #TODO: maybe limit to user role?

      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Request::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def setup_model!(options, current_user:, **)
        #options[:model].club = current_club
        options[:model].user = current_user
      end

    end
  end
end
