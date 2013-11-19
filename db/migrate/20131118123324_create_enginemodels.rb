class CreateEnginemodels < ActiveRecord::Migration
  def change
    create_table :enginemodels do |t|
      t.string :modelcode
      t.string :name

      t.timestamps
    end
  end
end
