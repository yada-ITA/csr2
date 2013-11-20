class AddEngineIdToRepairorder < ActiveRecord::Migration
  def change
    add_column :repairorders, :engine_id, :integer
  end
end
