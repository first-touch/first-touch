module V1
  module RequestBid
    class Index < FirstTouch::Operation
      step :find_model!
      step :filters!
      step :orders!

      private

      def find_model!(options, current_user:, **)
        if current_user.is_a?(::User) && current_user.scout?
          models = current_user.request_bids
        elsif current_user.is_a?(::Club) || true
          # Todo: or true need to be remove when club are ready
          # models = current_user.requests.where.not(status: 'deleted')
        end
        options['models'] = models
        options['model.class'] = ::Request
      end

    end
  end
end
