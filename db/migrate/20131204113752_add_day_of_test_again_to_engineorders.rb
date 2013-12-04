class AddDayOfTestAgainToEngineorders < ActiveRecord::Migration
  def change
    add_column :engineorders, :day_of_test, :date
  end
end
