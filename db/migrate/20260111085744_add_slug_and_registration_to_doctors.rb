class AddSlugAndRegistrationToDoctors < ActiveRecord::Migration[8.1]
  def change
    add_column :doctors, :slug, :string, null: false
    add_column :doctors, :registration_number, :string

    add_index :doctors, :slug, unique: true
    add_index :doctors, :registration_number, unique: true
    add_index :doctors, :phone, unique: true
  end
end
