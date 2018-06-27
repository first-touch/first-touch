module V1
  module Competition
    class Index < FirstTouch::Operation
      step :setup_model!

      def setup_model!(options, params:, **)
        competition_list = ::Competition.all.limit(7)
        query_params = params[:q]
        options['models'] = nil
        if query_params
          competition_list = competition_list.where(
            'name ILIKE ?', "%#{query_params}%"
          )
          options['models'] = competition_list
        end
      end
    end
  end
end
