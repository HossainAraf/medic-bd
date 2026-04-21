# Web Foundation Checklist

## Branch
- epic/fullstack-foundation

## Routing
- [✅] Keep all `/api/v1` routes unchanged
- [✅] Add root web route
- [✅] Add web specialization index route under web module scope

## Controllers
- [✅] Ensure `Web::BaseController` uses web-compatible behavior
- [✅] Add `Web::HomeController#index`
- [✅] Keep `Web::SpecializationsController#index` working

## Views/Layout
- [ ] Add `app/views/layouts/web.html.erb`
- [✅] Add `app/views/web/home/index.html.erb`
- [✅] Keep `app/views/web/specializations/index.html.erb` rendering
- [] Configure tailwind css.

## Security and Config
- [✅] Web pages use CSRF/session-safe behavior
- [ ] API auth callback does not block web pages
- [✅] CORS policy remains API-focused and not globally overbroad

## Quality
- [✅] Run `bundle exec rubocop --color`
- [✅] Run `bundle exec rails test`
- [✅] Verify root page and specialization page in browser

## Out of Scope
- [ ] Search alias migration
- [ ] Typo-intent search logic
- [ ] Database redesign
