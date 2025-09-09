class RemoveDuplicateDoctorsForProduction < ActiveRecord::Migration[7.1]
  def up
    # Safe SQL to remove duplicates in production
    execute <<~SQL
      DELETE FROM doctors 
      WHERE id NOT IN (
        SELECT MIN(id) 
        FROM doctors 
        GROUP BY name, bangla_name
      )
      AND (name, bangla_name) IN (
        SELECT name, bangla_name 
        FROM doctors 
        GROUP BY name, bangla_name 
        HAVING COUNT(*) > 1
      );
    SQL
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
