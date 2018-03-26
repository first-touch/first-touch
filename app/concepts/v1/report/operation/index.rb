module V1
  module Report
    class Index < FirstTouch::Operation
      step :find_model!

      private

      def find_model!(options, params:, current_user:, **)
        options['models'] = ::Report.all
        true
      end
    end
  end
end
