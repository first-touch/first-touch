class Club::Index < Trailblazer::Operation
  step :setup_model!

  def setup_model!(options, params:, **)
    clubs = Club.all
    if params[:q]
      clubs = clubs.where('name iLIKE ?', "%#{params[:q]}%")
    end
    options["model"] = clubs
  end
end
