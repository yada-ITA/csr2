class AddRetuningCommentToRepairs < ActiveRecord::Migration
  def change
    add_column :repairs, :returningComment, :text
  end
end
