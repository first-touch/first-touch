module V1
  module Message
    class Create < Trailblazer::Operation
      step Model(::Message, :new)
      step :find_recipient!
      failure :invalid_recipient
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(constant: Message::Contract::Create)
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      private

      def find_recipient!(options, params:, **)
        options[:recipient] = ::User.find_by(id: params[:recipient_id])
        !options[:recipient].nil?
      end

      def invalid_recipient(options, params:, **)
        options[:errors] = "Recipient with ID(#{params[:recipient_id]}) can't be found"
      end

      def setup_model!(_options, model:, recipient:, current_user:, **)
        model.message_recipient = MessageRecipient.new(
          recipient: recipient
        )
        model.creator = current_user
      end
    end
  end
end
