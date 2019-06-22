module V1
  module RequestBid
    module Operation
      module Scout
        class Index < FirstTouch::Operation
          step :find_models!
          step :filter_by_status!
          step :filter_by_request_id!

          private

          def find_models!(options, current_user:, **)
            options[:models] = ::RequestBid.includes(:request)
                                           .where(user_id: current_user.id)
          end

          def filter_by_status!(options, params:, models:, **)
            return true unless params['status'].present?

            options[:models] = models.where(status: params['status'])
          end

          def filter_by_request_id!(options, params:, models:, **)
            return true unless params['request_id'].present?

            options[:models] = models.includes(:request).where(request_id: params['request_id'])
          end
        end
      end
    end
  end
end
