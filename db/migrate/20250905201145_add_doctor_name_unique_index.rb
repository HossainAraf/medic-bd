class AddDoctorNameUniqueIndex < ActiveRecord::Migration[7.1]
  def change
    add_index :doctors, [:name, :bangla_name], unique: true, name: 'index_doctors_on_name_and_bangla_name_unique'
  end
end
