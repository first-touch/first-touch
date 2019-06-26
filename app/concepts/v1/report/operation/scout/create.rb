module V1
  module Report
    module Operation
      module Scout
        class Create < FirstTouch::Operation
          step Model(::Report, :new)
          step :setup_model
          step :associate_player
          step Trailblazer::Operation::Contract::Build(
            constant: Report::Contract::Create
          )
          step Trailblazer::Operation::Contract::Validate()
          step Trailblazer::Operation::Contract::Persist()
          # TODO: Associate with a request_bid if there is one
          # step :find_request_bid!
          # failure :invalid_associated_request_bid, fail_fast: true

          private

          def setup_model(_opts, model:, current_user:, **)
            model.user = current_user
          end

          # TODO: Cleanup this logic
          def associate_player(_opts, model:, params:, **)
            return true unless params['type_report'] == 'Player'
            return true if params['player']['id'].present?
            player_data = params['player']
            profile_data = params['meta_data']['player_info']
            email = "#{player_data['first_name']}_#{player_data['last_name']}_new@firsttouch.io"
            pwd = SecureRandom.hex
            unclaimed_player = ::User.create(email: email,
                                             password: pwd,
                                             password_confirmation: pwd,
                                             unclaimed: true)
            unclaimed_player.add_role 'player'
            unclaimed_player.create_personal_profile(first_name: player_data['first_name'],
                                                     last_name: player_data['last_name'],
                                                     weight: profile_data['weight'],
                                                     height: profile_data['height'],
                                                     preferred_foot: profile_data['preferred_foot'],
                                                     birthday: profile_data['birthday'],
                                                     nationality_country_code: profile_data['nationality_country_code'],
                                                     residence_country_code: profile_data['residence_country_code'],
                                                     languages: profile_data['languages'],
                                                     playing_positions: profile_data['playing_positions'])

            model.player = unclaimed_player
            model.player.teams = ::Team.where(id: params['team']['id'])
          end

          def find_request_bid!(_opts, params:, current_user:, model:, **)
            return true unless params['report']['request_bid_id']

            request_bid_id = params['report']['request_bid_id']
            model.request_bid = current_user.request_bids.find_by(id: request_bid_id)
            !model.request_bid.nil?
          end
        end
      end
    end
  end
end
