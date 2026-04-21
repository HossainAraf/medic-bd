
## Install rails application

## Configure Database

## Configure Routes

## Controller seperation for api and web

## Common pitfalls

See `docs/pitfalls/README.md` for known setup/debug issues and proven fixes.

## View/UI

### Add layout file

Use the web layout at `app/views/layouts/web.html.erb`.

Important asset note for current setup:
- Use Tailwind stylesheet include:
```erb
<%= stylesheet_link_tag "tailwind", "data-turbo-track": "reload" %>
```
- Do not use `application.css` include unless Sprockets manifest and source files are configured.
- Do not use `javascript_include_tag "application"` until a JS pipeline/entrypoint is configured.

### Configure tailwind css

Add Tailwind CSS gem
```ruby
bundle add tailwindcss-rails
```

Install Tailwind CSS
```ruby
bin/rails tailwindcss:install
```

Add `sprockets-rails` gem to ensure asset pipeline tasks are available
```ruby
bundle add sprockets-rails
```

Build and verify Tailwind output
```bash
bundle exec rails tailwindcss:build
ls -lah app/assets/builds/tailwind.css
```

For active UI development
```bash
bundle exec rails tailwindcss:watch
```

If styles appear stale, clear asset cache and restart:
```bash
rm -rf tmp/cache/assets public/assets
bundle exec rails tailwindcss:build
bundle exec rails s
```
