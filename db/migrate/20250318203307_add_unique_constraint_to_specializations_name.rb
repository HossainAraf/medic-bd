class AddUniqueConstraintToSpecializationsName < ActiveRecord::Migration[7.1]
  def change
    add_index :specializations, :name, unique: true
  end
end
