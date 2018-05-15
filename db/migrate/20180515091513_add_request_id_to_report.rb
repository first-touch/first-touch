class AddRequestIdToReport < ActiveRecord::Migration[5.1]
  def change
    add_reference :reports, :request, foreign_key: true
  end
end
