class AddUniqueIndexToDistrictNameAndSpecializationName < ActiveRecord::Migration[8.1]
  def change
    add_index :districts, :name, unique: true
    add_index :specializations, :name, unique: true
  end
end
