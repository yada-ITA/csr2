class AddCompanyIdToEngines < ActiveRecord::Migration
  def change
    add_column :engines, :company_id, :integer
  end
end
