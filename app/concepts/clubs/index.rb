class Club
  class Index < Trailblazer::Operation
    step :setup_model!

    def setup_model!(options, params:, **)
      clubs = Club.all
      clubs = clubs.where('name iLIKE ?', "%#{params[:q]}%") if params[:q]
      options['model'] = clubs
    end
  end
end
