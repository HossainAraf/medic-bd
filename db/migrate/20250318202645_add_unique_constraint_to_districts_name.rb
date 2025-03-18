class AddUniqueConstraintToDistrictsName < ActiveRecord::Migration[7.1]
  def change
    add_index :districts, :name, unique: true
  end
end
