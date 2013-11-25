class AddLocationcolsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :postcode, :string
    add_column :companies, :address, :string
    add_column :companies, :phoneNo, :string
    add_column :companies, :destinationName, :string
  end
end
