class AddTitleToEngineorders < ActiveRecord::Migration
  def change
    add_column :engineorders, :title, :string
  end
end
