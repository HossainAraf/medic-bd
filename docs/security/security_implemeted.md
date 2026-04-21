# Security implemented:

- Use environment variables in database configuration.

- Add CSRF protection in `Web::BaseController`.

- Restrict web routes and keep CORS scoped to the API domain set.

- Prevent exposure of private routes.