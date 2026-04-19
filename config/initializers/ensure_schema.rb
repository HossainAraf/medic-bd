db_task_running = ARGV.any? { |arg| arg.start_with?('db:') }

unless db_task_running
  ActiveSupport.on_load(:active_record) do
    schema = 'medicbd'
    connection = ActiveRecord::Base.connection
    next if connection.schema_exists?(schema)

    if Rails.env.production?
      raise <<~MSG
        ❌ Required database schema '#{schema}' does not exist.
        Run: CREATE SCHEMA #{schema};
      MSG
    end

    connection.execute(%(CREATE SCHEMA IF NOT EXISTS "#{schema}"))
  end
end
