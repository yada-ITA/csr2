class AddSuspendedToEngine < ActiveRecord::Migration
  def change
    add_column :engines, :suspended, :boolean
  end
end
