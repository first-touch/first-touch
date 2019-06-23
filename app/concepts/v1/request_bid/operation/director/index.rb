module V1
  module RequestBid
    module Operation
      module Director
        class Index < FirstTouch::Operation
          step :find_models!
          step :filter_by_status!

          private

          def find_models!(options, params:, current_user:, **)
            return false unless params['request_id'].present?

            options[:models] = ::RequestBid.includes(:request)
                                           .where(request_id: params['request_id'])
          end

          def filter_by_status!(options, params:, models:, **)
            return true unless params['status'].present?

            options[:models] = models.where(status: params['status'])
          end

        end
      end
    end
  end
end
