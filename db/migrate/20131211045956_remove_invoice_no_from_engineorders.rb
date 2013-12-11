class RemoveInvoiceNoFromEngineorders < ActiveRecord::Migration
  def change
    remove_column :engineorders, :invoice_no, :string
  end
end
