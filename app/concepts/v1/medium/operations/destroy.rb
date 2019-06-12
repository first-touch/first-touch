module V1
  module Medium
    class Destroy < FirstTouch::Operation
      step :validate_user
      failure :unauthorized!, fail_fast: true
      step :find_model
      failure :model_not_found!, fail_fast: true
      step :destroy

      def validate_user(_options, current_user:, params:, **)
        current_user.id == params[:user_id].to_i
      end

      def find_model(options, current_user:, params:, **)
        options['model.class'] = ActiveStorage::Attachment
        options[:model] = current_user.media.find params[:id]
        options['result.model'] = Result.new(!options[:model].nil?, {})
      end

      def destroy(options, **)
        options['model.action'] = :destroy
        options[:model].purge
      end
    end
  end
end
