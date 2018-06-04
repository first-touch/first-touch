module V1
  module Report
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :user, getter: lambda { |represented:, **|
          ::V1::PersonalProfile::Representer::Simplified.new(
            represented.user.personal_profile
          )
        }
        property :completion_status
        property :request, getter: lambda { |represented:, **|
          if represented.request
            ::V1::Request::Representer::Full.new(
              represented.request
            )
          end
        }
        property :created_at
        property :headline
        property :meta_data
        property :player, getter: lambda { |represented:, **|
          if represented.player
            ::V1::PersonalProfile::Representer::Simplified.new(
              represented.player.personal_profile
            )
          end
        }
        property :team_info, getter: lambda { |represented:, **|
          if represented.player
            ::V1::Team::Representer::Index.new(
              represented.player.teams
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
        property :team, getter: lambda { |represented:, **|
          'N/A'
          if represented.team
            ::V1::Team::Representer::Simplified.new(
              represented.team
            )
          end
        }
        property :price
        property :type_report
        property :status
        property :attachments, getter: lambda { |represented:, **|
          if represented.attachments
            ::V1::Attachment::Representer::IndexFull.new(represented.attachments)
          end
        }
      end
    end
  end
end
