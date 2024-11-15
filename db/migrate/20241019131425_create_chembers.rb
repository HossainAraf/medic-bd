class CreateChembers < ActiveRecord::Migration[7.1]
  def change
    create_table :chembers do |t|
      t.string :name
      t.string :type
      t.string :address
      t.integer :district_id

      t.timestamps
    end
  end
end
