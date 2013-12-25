class AddAllocateddateToEngineorders < ActiveRecord::Migration
  def change
    add_column :engineorders, :allocated_date, :date
  end
end
