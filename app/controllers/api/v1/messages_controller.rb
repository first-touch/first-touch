module Api
  module V1
    class MessagesController < Api::V1::BaseController
      def index
        # TODO: In the future, this should send only the index of messages
        # and another request should be made to fetch the full message
        chats = @current_user.inbox.map do |from, messages|
          Chat.new(
            from: from,
            last_message: messages.last,
            current_user: @current_user
          )
        end

        render json: chats, each_serializer: ChatSerializer, root: 'inbox'
      end

      def show
        begin
          user = ::User.find(chat_params[:chat_with_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { error: 'User not found' }, status: :unprocessable_entity
          return
        end

        full_chat = @current_user.full_chat_with user

        render json: {
          chat_with: {
            id: user.id,
            display_name: user.display_name
          },
          messages: full_chat
        }, status: :ok
      end

      def create
        new_message = Message.new(message_params.merge(creator_id: @current_user.id))
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

      def chat_params
        params.permit(:chat_with_id)
      end
    end
  end
end
