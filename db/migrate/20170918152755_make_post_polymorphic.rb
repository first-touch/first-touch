class MakePostPolymorphic < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :author_id, :integer
    add_column :posts, :author_type, :string
  end
end
