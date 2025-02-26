module V1
  module Report
    module Representer
      class Resume < Representable::Decorator
        include Representable::JSON

        property :id
        property :headline
        property :price
        property :type_report
        property :status
        property :completion_status
        property :created_at
        property :updated_at
        property :user, getter: lambda { |represented:, **|
          ::V1::PersonalProfile::Representer::Simplified.new(
            represented.user.personal_profile
          )
        }
        property :has_request, getter: lambda { |represented:, **|
          !represented.request_id.nil?
        }
        property :is_free, getter: lambda { |represented:, **|
          represented.price['value'] == 0 if represented.price
        }

        property :player, getter: lambda { |represented:, **|
          if represented.player && (represented.type_report == 'player')
            ::V1::PersonalProfile::Representer::Simplified.new(
              represented.player.personal_profile
            )
          end
        }

        property :attachments, getter: lambda { |represented:, **|
          if represented.attachments
            ::V1::Attachment::Representer::Index.new(represented.attachments)
          end
        }

        property :team_info, getter: lambda { |represented:, **|
          if represented.player && (represented.type_report == 'player')
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
        property :orders_status, getter: lambda { |represented:, **|
          begin
            represented.orders_status
          rescue StandardError
            'N/A'
          end
        }
        property :orders_completed_date, getter: lambda { |represented:, **|
          begin
            represented.orders_completed_date
          rescue StandardError
            'N/A'
          end
        }
        property :orders_refund_status, getter: lambda { |represented:, **|
          begin
            represented.orders_refund_status
          rescue StandardError
            'N/A'
          end
        }

        property :orders_price, getter: lambda { |represented:, **|
          begin
            represented.orders_price
          rescue StandardError
            'N/A'
          end
        }
        property :search, getter:  lambda { |represented:, **|
          if represented.meta_data && (represented.request.nil? || represented.request.type_request != 'position')
            represented.meta_data['search'] if represented.meta_data['search']
          end
        }
        property :meta_data, getter: lambda { |represented:, **|
          if represented.meta_data
            ::V1::ReportMetaData::Representer::Resume.new(
              represented.meta_data
            )
          end
        }
      end
    end
  end
end
