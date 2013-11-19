class CreateEngines < ActiveRecord::Migration
  def change
    create_table :engines do |t|
      t.string :engineModelName
      t.string :salesModelName

      t.timestamps
    end
  end
end
