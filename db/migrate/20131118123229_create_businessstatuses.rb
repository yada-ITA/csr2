class CreateBusinessstatuses < ActiveRecord::Migration
  def change
    create_table :businessstatuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
