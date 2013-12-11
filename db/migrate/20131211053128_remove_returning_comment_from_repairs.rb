class RemoveReturningCommentFromRepairs < ActiveRecord::Migration
  def change
    remove_column :repairs, :returning_comment, :string
  end
end
