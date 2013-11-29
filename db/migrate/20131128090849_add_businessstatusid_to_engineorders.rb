class AddBusinessstatusidToEngineorders < ActiveRecord::Migration
  def change
    add_column :engineorders, :businessstatus_id, :integer
  end
end
