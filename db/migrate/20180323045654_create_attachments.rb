class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.text :url
      t.text :filename
	  
      t.timestamps
    end
  end
end
