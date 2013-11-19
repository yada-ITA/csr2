class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :postcode
      t.string :address
      t.string :phoneNo
      t.string :destinationName

      t.timestamps
    end
  end
end
