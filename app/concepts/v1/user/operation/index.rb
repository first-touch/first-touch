module V1
  module User
    class Index < FirstTouch::Operation
      step :setup_model!

      def setup_model!(options, params:, **)
        user_list = ::User.all
        query_params = params[:q]

        if query_params
          user_list = user_list.where(
            'search_string ILIKE ?', "%#{query_params}%"
          )
        end
        options['models'] = user_list
      end
    end
  end
end
