module V1
  module Attachment
    class Find < Trailblazer::Operation
      step :setup_model!

      def setup_model!(options, params:, current_user:, **)
        attachments = []
        if is_scout? current_user
          attachments = ::Attachment.joins(:report_data => {:report => :user}).where("attachments.id" => params[:attachment_id], "reports.user_id" => current_user.id).select("distinct attachments.*")
        elsif is_club? current_user
          attachments = ::Attachment.joins(:report_data => {:report => {:orders => :user}}).where("attachments.id" => params[:attachment_id], "orders.customer_id" => current_user.id, "orders.status" => 'completed').select("distinct attachments.*")
        end
        options['model'] = attachments.first
      end

      def is_club?(current_user)
        true
      end

      def is_scout?(current_user)
        current_user.roles.first.name == 'scout'
      end
    end
  end
end
