class ChangePriceToBeJsonInReports < ActiveRecord::Migration[5.1]
  def change
    change_column :reports, :price, "json USING '{\"price\": 0}'"

  end
end
