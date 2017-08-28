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

      def setup_model!(model:, params:, current_user:, **)
        model.status = if params[:user_id] == current_user.id
                         ::Connection::ACCEPTED
                       else
                         ::Connection::PENDING
                       end
      end
    end
  end
end
