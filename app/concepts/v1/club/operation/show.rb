module V1
  module Club
    class Show < Trailblazer::Operation
      step Model(::Club, :find_by)
    end
  end
end
