module V1
  module Message
    class Show < FirstTouch::Operation
      step :find_chat_with!
      failure :user_not_found!
      step :get_full_chat!

      def find_chat_with!(options, params:, **)
        options[:chat_with] = ::User.find(params[:chat_with_id])
        !options[:chat_with].nil?
      end

      def get_full_chat!(options, current_user:, chat_with:, **)
        options[:model] = ::V1::Message::FullChat.new(
          nil,
          messages: current_user.full_chat_with(chat_with),
          chat_with: chat_with
        )
      end
    end
  end
end
