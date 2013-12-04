class AddInvoiceNoToEngineorders < ActiveRecord::Migration
  def change
    add_column :engineorders, :invoice_no, :string
  end
end
