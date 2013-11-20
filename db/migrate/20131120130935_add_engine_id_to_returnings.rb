class AddEngineIdToReturnings < ActiveRecord::Migration
  def change
    add_column :returnings, :engine_id, :integer
  end
end
