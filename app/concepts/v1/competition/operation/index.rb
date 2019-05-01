module V1
  module Competition
    class Index < FirstTouch::Operation
      step :setup_model!

      def setup_model!(options, params:, **)
        competitions = ::Competition.limit(7)
        query_params = params[:q]
        if query_params
          competitions = competitions.where(
            'name ILIKE ?', "%#{query_params}%"
          )
        end
        options[:models] = competitions
      end
    end
  end
end
