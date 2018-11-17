module V1
  module Connection
    class Create < Trailblazer::Operation
      step Model(::Connection, :new)
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Connection::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def setup_model!(options, params:,  **)
        options[:model].status = if params[:user_id] == options[:current_user].id
                         ::Connection::ACCEPTED
                       else
                         ::Connection::PENDING
                       end
      end
    end
  end
end
