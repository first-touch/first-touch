module V1
  module Request
    module Operation
      module Scout
        class Index < FirstTouch::Operation
          step :find_model!

          private

          def find_model!(options, current_user:, **)
            models = ::Request.all
            joins = "LEFT OUTER JOIN request_bids ON request_bids.request_id = requests.id AND request_bids.user_id = #{current_user.id} AND request_bids.status != 'canceled' "
            models = models.joins(joins)
            models = models.where('request_bids.status IN (\'pending\', \'accepted\') OR requests.status = ?', 'publish')
            options[:models] = models.select('requests.*, request_bids.status as bid_status, request_bids.price as bid_price, request_bids.report_id as report_id').uniq
          end
        end
      end
    end
  end
end
