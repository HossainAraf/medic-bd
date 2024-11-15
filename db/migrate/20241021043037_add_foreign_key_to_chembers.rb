class AddForeignKeyToChembers < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :chembers,  :districts
  end
end
