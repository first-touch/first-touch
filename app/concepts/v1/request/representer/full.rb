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
          if represented.player
            ::V1::PersonalProfile::Representer::Simplified.new(
              represented.player.personal_profile
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

        property :league, getter: lambda { |represented:, **|
          if represented.league
            ::V1::Competition::Representer::Simplified.new(
              represented.league
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

        property :bid_price, getter: lambda { |represented:, **|
          begin
            represented.bid_price
          rescue StandardError
            'N/A'
          end
        }

        property :bid_status, getter: lambda { |represented:, **|
          begin
            represented.bid_status
          rescue StandardError
            'N/A'
          end
        }
        property :report_id, getter: lambda { |represented:, **|
          begin
            represented.report_id
          rescue StandardError
            'N/A'
          end
        }
      end
    end
  end
end
