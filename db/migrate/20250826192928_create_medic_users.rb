class CreateMedicUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :medic_users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :password_digest
      t.string :role
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
    add_index :medic_users, :email, unique: true
  end
end
