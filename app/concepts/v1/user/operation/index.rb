module V1
  module User
    class Index < Trailblazer::Operation
      # TODO: setup policy guard
      step :setup_model!

      def setup_model!(options, params:, **)
        user_list = ::User.all
        query_params = params[:q]

        if query_params
          user_list = user_list.where(
            'search_string ILIKE ?', "%#{query_params}%"
          )
        end
        options['model'] = user_list
      end
    end
  end
end
