class Statistics < ActiveRecord::Migration[5.1]
  def change
    create_table :statistics do |t|
      t.integer :stat_type
      t.jsonb :metadata, null: false, default: '{}'
      t.timestamps null: false
    end
  end
end
