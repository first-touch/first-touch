module V1
  module Message
    class Create < Trailblazer::Operation
      step Model(Message, :new)
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(constant: Message::Contract::Create)
      step Trailblazer::Operation::Contract::Validate(key: :message)
      step Trailblazer::Operation::Contract::Persist()

      private

      def setup_model!(options, params:,  **)
        recipient = User.find_by(id: params[:message][:recipient_id])
        options[:model].message_recipient = MessageRecipient.new(
          recipient: recipient
        )
        options[:model].creator = options[:current_user]
      end
    end
  end
end
