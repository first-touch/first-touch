module V1
  module Competition
    class Index < FirstTouch::Operation
      step :setup_model!

      def setup_model!(options, params:, **)
        competition_list = ::Competition.all.limit(5)
        query_params = params[:q]
        options['models'] = nil
        if query_params and query_params.length >= 3
          competition_list = competition_list.where(
            'name ILIKE ?', "%#{query_params}%"
          )
          if FirstTouch::REGISTERABLE_ROLE_NAMES.include? params[:role]
            competition_list = competition_list.with_role params[:role]
          end
          options['models'] = competition_list
        end
      end
    end
  end
end
