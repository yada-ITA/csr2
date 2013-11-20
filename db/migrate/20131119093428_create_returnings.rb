class CreateReturnings < ActiveRecord::Migration
  def change
    create_table :returnings do |t|
      t.date :returnDate
      t.text :returningComment
      t.text :sendingComment

      t.timestamps
    end
  end
end
