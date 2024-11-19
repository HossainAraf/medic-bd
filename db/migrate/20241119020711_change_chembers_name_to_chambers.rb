class ChangeChembersNameToChambers < ActiveRecord::Migration[7.1]
  def change
    rename_table :chembers, :chambers
  end
end
