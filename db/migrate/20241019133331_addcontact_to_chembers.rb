class AddcontactToChembers < ActiveRecord::Migration[7.1]
  def change
    add_column :chembers, :contact, :string
  end
end
