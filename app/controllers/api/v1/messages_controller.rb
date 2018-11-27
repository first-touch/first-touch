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
        result = ::V1::Message::Show.(params: params, current_user: current_user)
        res = FirstTouch::Endpoint.(result, ::V1::Chat::Representer::FullChat)
        render json: res[:data], status: res[:status]
      end

      def create
        op = ::V1::Message::Create.(params: params, current_user: current_user)
        res = FirstTouch::Endpoint.(op, ::V1::Message::Representer::Simple)
        render json: res[:data], status: res[:status]
        # new_message = Message.new(message_params.merge(creator_id: @current_user.id))
        # if new_message.save
        #   render json: { message: new_message }, status: :created
        # else
        #   render json: { error: new_message.errors.full_messages },
        #          status: :unprocessable_entity
        # end
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
