class CreateChembers < ActiveRecord::Migration[7.1]
  def change
    create_table :chembers do |t|
      t.string :name
      t.string :type
      t.string :address
      t.references :district, null: false, foreign_key: true

      t.timestamps
    end
  end
end
