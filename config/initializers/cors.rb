Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "https://medic-bd.com", "http://localhost:3000"

    resource "/api/*", # Only allow API routes
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
