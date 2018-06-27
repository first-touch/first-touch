module V1
  module Team
    class Index < FirstTouch::Operation
      step :setup_model!

      def setup_model!(options, params:, **)
        options['models'] = []
        team_list = ::Team.all.limit(7)
        query_params = params[:q]
        if query_params
          team_list = team_list.joins(:competitions).select('teams.*, competitions.name as competition_name, competitions.id as competition_id')
          team_list = team_list.where('competitions.id = ?', params[:league].to_i) unless params[:league].blank?
          team_list = team_list.where(
            'team_name ILIKE ?', "%#{query_params}%"
          )
          options['models'] = team_list
        end
      end
    end
  end
end
