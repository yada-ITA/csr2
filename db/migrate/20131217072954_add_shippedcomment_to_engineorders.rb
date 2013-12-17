class AddShippedcommentToEngineorders < ActiveRecord::Migration
  def change
    add_column :engineorders, :shipped_comment, :text
  end
end
