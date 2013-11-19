class CreateArrivals < ActiveRecord::Migration
  def change
    create_table :arrivals do |t|
      t.date :arrivalDate
      t.text :arrivalComment

      t.timestamps
    end
  end
end
