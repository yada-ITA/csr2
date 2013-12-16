class AddReturningPlaceIdToEngineorder < ActiveRecord::Migration
  def change
    add_column :engineorders, :returning_place_id, :integer
  end
end
