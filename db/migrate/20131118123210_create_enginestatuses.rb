class CreateEnginestatuses < ActiveRecord::Migration
  def change
    create_table :enginestatuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
