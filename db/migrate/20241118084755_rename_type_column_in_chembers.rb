class RenameTypeColumnInChembers < ActiveRecord::Migration[7.1]
  def change
    rename_column :chembers, :type, :category
  end
end
