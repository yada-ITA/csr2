class CreateReturns < ActiveRecord::Migration
  def change
    create_table :returns do |t|
      t.date :returnDate
      t.text :returnComment
      t.text :sendingComment

      t.timestamps
    end
  end
end
