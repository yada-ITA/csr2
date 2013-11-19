class CreateRepairs < ActiveRecord::Migration
  def change
    create_table :repairs do |t|
      t.string :issueNo
      t.date :issueDate
      t.date :arriveDate
      t.date :startDate
      t.date :finishDate
      t.text :beforeComment
      t.text :afterComment

      t.timestamps
    end
  end
end
