class AddShippedDateToEngineorders < ActiveRecord::Migration
  def change
    add_column :engineorders, :shipped_date, :date
  end
end
