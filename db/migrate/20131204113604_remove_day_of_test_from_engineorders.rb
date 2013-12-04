class RemoveDayOfTestFromEngineorders < ActiveRecord::Migration
  def change
    remove_column :engineorders, :day_of_test, :string
  end
end
