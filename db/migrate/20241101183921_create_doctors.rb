class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.string :name
      t.references :specializations, foreign_key: true
      t.string  :
      t.timestamps
    end
  end
end
