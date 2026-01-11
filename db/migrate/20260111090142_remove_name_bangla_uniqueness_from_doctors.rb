class RemoveNameBanglaUniquenessFromDoctors < ActiveRecord::Migration[8.1]
  def change
    remove_index :doctors, name: "index_doctors_on_name_and_bangla_name_unique"
  end
end
