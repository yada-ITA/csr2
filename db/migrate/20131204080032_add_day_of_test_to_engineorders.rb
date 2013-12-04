class AddDayOfTestToEngineorders < ActiveRecord::Migration
  def change
    add_column :engineorders, :day_of_test, :string
  end
end
