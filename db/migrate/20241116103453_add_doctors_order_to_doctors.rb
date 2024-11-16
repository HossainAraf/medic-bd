class AddDoctorsOrderToDoctors < ActiveRecord::Migration[7.1]
  def change
    #Add new column to doctors table
    add_column :doctors, :order, :integer
  end
end
