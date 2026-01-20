ActiveSupport.on_load(:active_record) do
  schema = "medicbd"

  unless ActiveRecord::Base.connection.schema_exists?(schema)
    raise <<~MSG
      ❌ Required database schema '#{schema}' does not exist.
      Run: CREATE SCHEMA #{schema};
    MSG
  end
end
