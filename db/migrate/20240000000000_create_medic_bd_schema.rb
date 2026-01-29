class CreateMedicBdSchema < ActiveRecord::Migration[8.1]
  def up
    execute "CREATE SCHEMA IF NOT EXISTS medicbd"
  end

  def down
    execute "DROP SCHEMA IF EXISTS medicbd CASCADE"
  end
end
