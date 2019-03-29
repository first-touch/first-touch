module V1
  module User
    class Import < Trailblazer::Operation
      step :setup_model!
      step :register_or_init!
      step :associate_club

      private

      def setup_model!(options, params:, **)
        options[:model] = ::User.find_or_initialize_by email: params['email']
      end

      def register_or_init!(options, params:, **)
        model = options[:model]
        return true if model.persisted?
        model.personal_profile = ::PersonalProfile.new
        model.personal_profile.first_name = params['first_name']

        model.personal_profile.middle_name = params['middle_name']

        model.personal_profile.last_name = params['last_name']
        model.personal_profile.birthday = params['birthday']
        model.personal_profile.place_of_birth = params['place_of_birth']
        model.personal_profile.weight = params['weight']
        model.personal_profile.height = params['height']
        model.personal_profile.preferred_foot = params['preferred_foot']
        model.personal_profile.playing_positions = params['playing_positions']
        model.personal_profile.pro_status = params['pro_status']
        model.personal_profile.total_caps = params['total_caps']
        model.personal_profile.languages = params['languages']
        begin
          model.personal_profile.residence_country_code = IsoCountryCodes.search_by_name(params['residence_country_code']).first
          iso_country = IsoCountryCodes.search_by_name(params['nationality']).first
          model.personal_profile.nationality_country_code = iso_country&.alpha2
        rescue StandardError
        end
        # Create unclaimed account and email
        pwd = SecureRandom.hex
        model.add_role 'player'
        model.email = model.personal_profile.first_name + model.personal_profile.last_name + '_new@firsttouch.io'
        model.password = pwd
        model.password_confirmation = pwd
        model.unclaimed = true
      end

      def associate_club(options, club_id:, **)
        model = options[:model]
        club = ::Club.find_by id: club_id
        model.clubs << club if club
        model.save
      end
    end
  end
end
