class AddContactToChambers < ActiveRecord::Migration[8.1]
  def change
    add_column :chambers, :contact, :string, null: false, default: ''
  end
end
