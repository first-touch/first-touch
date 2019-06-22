module V1
  module RequestBid
    module Operation
      module Scout
        class Index < FirstTouch::Operation
          step :find_models!
          step :filter!

          private

          def find_models!(options, current_user:, **)
            options[:models] = ::RequestBid.includes(:request)
                                           .where(user_id: current_user.id)
          end

          def filter!(options, params:, models:, **)
            return true unless params['status'].present?

            options[:models] = models.where(status: params['status'])
          end
        end
      end
    end
  end
end
