class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.integer :loginUserId
      t.integer :branchCode
      t.integer :userId
      t.integer :placeCode
      t.string :orderer
      t.string :machineNo
      t.integer :timeOfRunning
      t.date :dayOfTest
      t.text :changeComment

      t.timestamps
    end
  end
end
