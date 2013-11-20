class AddEngineIdToRepairs < ActiveRecord::Migration
  def change
    add_column :repairs, :engine_id, :integer
  end
end
