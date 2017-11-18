module V1
  module Note
    class Show < FirstTouch::Operation
      step Model(::Note, :find_by)
      failure :model_not_found!, fail_fast: true
    end
  end
end
