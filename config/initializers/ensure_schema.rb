ActiveSupport.on_load(:active_record) do
  next if Rails.env.test?

  task_args = ARGV.dup
  task_args.concat(Rake.application.top_level_tasks) if defined?(Rake.application)

  # Skip strict schema guard during bootstrap/test tasks.
  next if task_args.any? { |arg| arg.start_with?('db:', 'test') }

  schema = "medicbd"

  unless ActiveRecord::Base.connection.schema_exists?(schema)
    raise <<~MSG
      ❌ Required database schema '#{schema}' does not exist.
      Run: CREATE SCHEMA #{schema};
    MSG
  end
end
