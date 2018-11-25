module V1
  module Club
    class Countries < Trailblazer::Operation
      step :setup_model!

      def setup_model!(options, **)
        uniq_countries = ::Club.pluck(:country_code).uniq
        options[:models] = uniq_countries.map do |country_code|
          country_struct = OpenStruct.new(
            country_code: country_code,
            country_name: find_iso_name(country_code)
          )
          ::V1::Twins::CountryTwin.new(country_struct)
        end
      end

      def find_iso_name(country_code)
        IsoCountryCodes.find(country_code)&.name
      rescue IsoCountryCodes::UnknownCodeError
        country_code
      end
    end
  end
end
