class CreateEngineorders < ActiveRecord::Migration
  def change
    create_table :engineorders do |t|
      t.string :issue_no
      t.date :inquiry_date
      t.integer :registered_user_id
      t.integer :updated_user_id
      t.integer :branch_id
      t.integer :salesman_id
      t.integer :install_place_id
      t.string :orderer
      t.string :machine_no
      t.integer :time_of_running
      t.text :change_comment
      t.date :order_date
      t.integer :sending_place_id
      t.text :sending_comment
      t.date :desirable_delivery_date
      t.integer :businessstatus_id
      t.integer :new_engine_id
      t.integer :old_engine_id

      t.timestamps
    end
  end
end
