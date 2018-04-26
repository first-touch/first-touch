module V1
  module Request
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :user, getter: lambda { |represented:, **|
          ::V1::PersonalProfile::Representer::Simplified.new(
            represented.user.personal_profile
          )
        }
        property :player, getter: lambda { |represented:, **|
          if represented.meta_data['player_id'].to_i > 0
            personal_profile = ::PersonalProfile.find_by user_id: represented.meta_data['player_id']
            ::V1::PersonalProfile::Representer::Simplified.new(
              personal_profile
            )
          end
        }

        property :team, getter: lambda { |represented:, **|
          if represented.team
            ::V1::Team::Representer::Simplified.new(
            represented.team
            )
          end
        }

        property :meta_data
        property :price
        property :type_request
        property :status
        property :deadline
        property :created_at
        property :request_bids_count, getter: lambda { |represented:, **|
          begin
            represented.request_bids_count
          rescue StandardError
            'N/A'
          end
        }

        property :request_bids, getter: lambda { |represented:, **|
          if represented.request_bids
            represented.request_bids.first
          end
        }

      end
    end
  end
end
