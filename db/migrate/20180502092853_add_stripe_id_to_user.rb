class AddStripeIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :stripe_id, :text
  end
end
