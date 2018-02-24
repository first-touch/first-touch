module V1
  module Twins
    class CountryTwin < Disposable::Twin
      property :country_name
      property :country_code
    end
  end
end
