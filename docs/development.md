# Development Plan: Web Foundation (epic/fullstack-foundation)

## Goal
Set up a clean web foundation (controllers, routes, layout, basic pages, and security boundaries) while keeping the existing API stable.

This branch intentionally avoids major database/search changes. Data/search work will be handled later in a dedicated branch.

## Scope for this branch
1. Web layer structure
2. Route separation between API and web pages
3. Basic MVC + ERB rendering path
4. CSRF/session safety for web pages
5. CORS boundary focused on API use
6. Basic responsive home page and baseline navigation
7. Basic tests for web entry points

## Current state (quick note)
1. App is still configured as `api_only` in `config/application.rb`.
2. `Web::BaseController` currently inherits from `ApplicationController`, which is API-auth oriented.
3. A web specialization page exists but root/home setup is not complete yet.

## Target architecture
1. API:
- Keep `/api/v1/*` behavior unchanged.
- JWT/stateless behavior remains in API controllers.

2. Web:
- Public URLs stay root-based (for SEO), while code stays namespaced under `Web::`.
- HTML rendering stack should be handled by web controllers based on `ActionController::Base` behavior.

## File and module structure (target)
1. Controllers
- `app/controllers/web/base_controller.rb`
- `app/controllers/web/home_controller.rb`
- `app/controllers/web/specializations_controller.rb`

2. Views
- `app/views/layouts/web.html.erb`
- `app/views/web/home/index.html.erb`
- `app/views/web/specializations/index.html.erb`

3. Routes
- Keep API namespace in `config/routes.rb`.
- Add web scope with `module: :web` for root and public pages.

## Security and boundary rules
1. CSRF
- Web controllers should use CSRF protection and standard browser safety behavior.
- API controllers remain stateless and should not adopt web CSRF assumptions.

2. CORS
- CORS should be restricted to API usage patterns.
- Avoid broad wildcard policy for all resources in production.

3. Authentication separation
- Do not run API `authorize_request` callbacks for web pages.
- Keep web and API concerns separated at base-controller level.

## Implementation sequence
1. Foundation
- Add/adjust `Web::BaseController` for web behavior.
- Add web layout.

2. Routing
- Keep API routes unchanged.
- Add web root route and specialization listing route using web module scope.

3. Home page
- Add `Web::HomeController#index`.
- Build basic responsive ERB home page with simple nav links.

4. Specialization page
- Keep basic listing page under web module.
- Ensure no API auth callback blocks web rendering.

5. Config alignment
- Review `config/application.rb` for middleware needs required by web pages.
- Keep CORS policy aligned to API surface.

6. Tests
- Add an integration test for root/home page.
- Add/adjust a controller/integration test for web specializations page.

## Done criteria for this branch
1. Web root page renders in browser.✅
2. Web specialization index renders successfully.✅
3. API routes and behavior remain backward-compatible.
4. CSRF/session behavior is correct for web pages.✅
5. CORS policy is not overbroad for production intent.✅
6. CI lint and test remain passing.

## Out of scope (explicit)
1. Alias dictionary/search migration
2. Query intelligence and typo-resolution engine
3. Large SEO/content expansion
4. Booking workflow and analytics events

## Next branch after this
Use a dedicated branch for search data model and query handling, for example:
- `feat/search-alias-foundation`

