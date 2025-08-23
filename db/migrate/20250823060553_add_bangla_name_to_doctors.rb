class AddBanglaNameToDoctors < ActiveRecord::Migration[7.1]
  def change
    add_column :doctors, :bangla_name, :string
  end
end
