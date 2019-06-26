module V1
  module Report
    module Operation
      module Scout
        class Index < FirstTouch::Operation
          step :find_models!

          private

          def find_models!(options, current_user:, **)
            options[:models] = ::Report.where(user_id: current_user.id)
          end
        end
      end
    end
  end
end
