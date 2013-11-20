class AddSerialnoToEngines < ActiveRecord::Migration
  def change
    add_column :engines, :serialno, :string
  end
end
