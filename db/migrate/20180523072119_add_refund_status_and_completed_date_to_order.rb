class AddRefundStatusAndCompletedDateToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :refund_status, :text
    add_column :orders, :completed_date, :datetime
  end
end
