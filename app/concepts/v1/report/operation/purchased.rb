module V1
  module Report
    class Purchased < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      private

      def find_model!(options, params:, current_user:, **)
        models = nil
        if is_club? current_user
          models = ::Report.joins(:orders => :user).where("orders.status" => 'completed').select("distinct reports.*")
          if !models.blank?
            models = models
          end
        end
        options['model.class'] = ::Report
        options['models'] = models
        true
      end

      def is_club?(current_user)
        true
      end

    end
  end
end
