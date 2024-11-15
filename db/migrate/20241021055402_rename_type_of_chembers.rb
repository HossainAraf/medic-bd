class RenameTypeOfChembers < ActiveRecord::Migration[7.1]
  def change
    rename_column  :chembers, :type, :chembers_type
  end
end
