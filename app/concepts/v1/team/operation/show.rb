module V1
  module Team
    class Show < FirstTouch::Operation
      step Model(::Team, :find_by)
      failure :model_not_found!, fail_fast: true
    end
  end
end
