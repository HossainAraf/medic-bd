class PreventDuplicateDoctors < ActiveRecord::Migration[7.1]
  def change
     # Add a unique index on the combination of name and bangla_name.
    # Prevent the creation of duplicate doctor records with the same name and bangla_name.
    add_index :doctors, [:name, :bangla_name], unique: true, name: 'index_doctors_on_name_and_bangla_name_unique'
  end
end
1