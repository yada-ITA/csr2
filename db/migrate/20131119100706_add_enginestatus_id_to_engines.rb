class AddEnginestatusIdToEngines < ActiveRecord::Migration
  def change
    add_column :engines, :enginestatus_id, :integer
  end
end
