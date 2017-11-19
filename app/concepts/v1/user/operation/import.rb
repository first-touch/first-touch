module V1
  module User
    class Import < Trailblazer::Operation
      step :setup_model!
      step :register_or_init!
      step :associate_club

      private

      def setup_model!(options, params:, **)
        options['model'] = ::User.find_or_initialize_by email: params['email']
      end

      def register_or_init!(model:, params:, **)
        return true if model.persisted?
        model.personal_profile = ::PersonalProfile.new
        model.personal_profile.first_name = params['first_name']
        model.personal_profile.last_name = params['last_name']
        model.personal_profile.birthday = params['birthday']
        iso_country = IsoCountryCodes.search_by_name(params['nationality']).first
        model.personal_profile.nationality_country_code = iso_country&.alpha2
        # Create unclaimed account and email
        pwd = SecureRandom.hex
        model.password = pwd
        model.password_confirmation = pwd
        model.unclaimed = true
      end

      def associate_club(model:, club_id:, **)
        club = ::Club.find_by id: club_id
        model.clubs << club
        model.save
      end
    end
  end
end
