class AddUniqueIndexToChambers < ActiveRecord::Migration[7.1]
  def change
    add_index :chambers, [:name, :district_id], unique: true, name: 'index_chambers_on_name_and_district_id'
  end
end
