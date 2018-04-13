module V1
  module Attachment
    class Find < Trailblazer::Operation
      step :setup_model!

      # @Todo will be remove once s3 upload is set
      def setup_model!(options, params:, current_user:, **)
        attachments = []
        if current_user.is_a?(::User) && current_user.scout?
          attachments = ::Attachment.joins(report: :user)
          attachments.where('attachments.id' => params[:attachment_id],
                            'reports.user_id' => current_user.id)
        elsif current_user.is_a?(::Club) || true
          # @Todo or true need to be remove when club are ready
          attachments = ::Attachment.joins(report: { orders: :user })
          attachments = attachments.where(
            'orders.customer_id' => current_user.id,
            'orders.status' => 'completed'
          )
        end
        attachments = attachments.select('distinct attachments.*')
        options['model'] = attachments.first
      end
    end
  end
end
