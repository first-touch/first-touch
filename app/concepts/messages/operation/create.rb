require_relative '../../message/contract/create'

class Messages
  class Create < Trailblazer::Operation
    step Model(Message, :new)
    step :setup_model!
    step Contract::Build(constant: Message::Contract::Create)
    step Contract::Validate(key: :message)
    step Contract::Persist()

    private

    def setup_model!(options, params:, current_user:, **)
      recipient = User.find_by(id: params[:message][:recipient_id])
      options['model'].message_recipient = MessageRecipient.new(
        recipient: recipient
      )
      options['model'].creator = current_user
    end
  end
end
