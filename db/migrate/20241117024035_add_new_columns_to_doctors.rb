class AddNewColumnsToDoctors < ActiveRecord::Migration[7.1]
  def change
    add_column :doctors, :specialty, :string, null: false
    add_column :doctors, :qualification, :string, null: false
    add_column :doctors, :experience, :string, null: false
    add_column :doctors, :phone, :string
    add_column :doctors, :order, :integer 
  end
end
