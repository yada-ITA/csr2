class CreateRepairorders < ActiveRecord::Migration
  def change
    create_table :repairorders do |t|
      t.string :issueNo
      t.date :issueDate
      t.string :orderNo
      t.string :constructionNo
      t.date :otherBrandPartsArrivealDate
      t.date :returnDate
      t.text :returningComment
      t.string :sendingComment

      t.timestamps
    end
  end
end
