class ConvertConnectionStatusToEnum < ActiveRecord::Migration[5.2]
  def up
    remove_column :connections, :status
    execute <<-SQL
      CREATE TYPE status AS ENUM ('requested', 'pending', 'accepted', 'rejected', 'blocked');
    SQL
    add_column :connections, :status, :status, index: true
  end
end
