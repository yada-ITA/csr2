class AddAttrs1211sToEngineorders < ActiveRecord::Migration
  def change
    add_column :engineorders, :returning_date, :date
    add_column :engineorders, :returning_comment, :text
    add_column :engineorders, :invoice_no_new, :string
    add_column :engineorders, :invoice_no_old, :string
  end
end
