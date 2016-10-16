module Api
  module V1
    class MessagesController < Api::V1::BaseController
      def index
        # TODO: In the future, this should send only the index of messages
        # and another request should be made to fetch the full message
        render json: { inbox: current_user.inbox }
      end

      def create
        new_message = Message.new(message_params.merge(creator_id: current_user.id))
        if new_message.save
          render json: { message: new_message }, status: :created
        else
          render json: { error: new_message.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      private

      def message_params
        params.require(:message)
          .permit(:message_body,
                  message_recipient_attributes: [
                    :recipient_id
                  ])
      end
    end
  end
end
