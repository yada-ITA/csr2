class AddShippedDateToRepairs < ActiveRecord::Migration
  def change
    add_column :repairs, :shipped_date, :date
  end
end
