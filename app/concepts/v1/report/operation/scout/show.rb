module V1
  module Report
    module Operation
      module Scout
        class Show < FirstTouch::Operation
          step Model(::Report, :find_by)
          failure :model_not_found!, fail_fast: true
          step :validate_resource_ownership!
          failure :model_not_found!, fail_fast: true

          private

          def validate_resource_ownership!(_opts, model:, current_user:, **)
            model.user_id == current_user.id
          end
        end
      end
    end
  end
end
