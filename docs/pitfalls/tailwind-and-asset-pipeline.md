# Tailwind and Asset Pipeline Pitfalls

## 1) `tailwindcss:install` fails with missing `assets:precompile`

### Symptom
`bin/rails tailwindcss:install` aborts with:
`Don't know how to build task 'assets:precompile'`

### Root Cause
The app originated from API-only setup and did not have Sprockets pipeline task wiring.

### Fix
1. Add `sprockets-rails` gem.
2. Run `bundle install`.
3. Re-run `bin/rails tailwindcss:install`.

### Verify
`bundle exec rails -T | grep assets:precompile` should show the task.

---

## 2) `ManifestNeededError` for `app/assets/config/manifest.js`

### Symptom
Install/build fails with `Sprockets::Railtie::ManifestNeededError`.

### Root Cause
Sprockets manifest file was missing.

### Fix
Create `app/assets/config/manifest.js` with:

```js
//= link_tree ../builds
```

### Verify
`bundle exec rails assets:precompile` runs successfully.

---

## 3) Install/build blocked by missing `secret_key_base`

### Symptom
During Tailwind install/build, production precompile path asks for `secret_key_base`.

### Root Cause
Installer triggers build paths that need secret in production context.

### Fix
Run with temporary env var:

```bash
SECRET_KEY_BASE=dummy bin/rails tailwindcss:install
```

### Verify
Command completes and creates `app/assets/tailwind/application.css` and `app/assets/builds/tailwind.css`.

---

## 4) `application.css` precompile error in `web.html.erb`

### Symptom
Error in layout:
`Asset 'application.css' was not declared to be precompiled in production.`

### Root Cause
Layout accidentally used:
`stylesheet_link_tag "application"`
while current setup only serves Tailwind build output.

### Fix
Use:

```erb
<%= stylesheet_link_tag "tailwind", "data-turbo-track": "reload" %>
```

Remove `javascript_include_tag "application"` until JS pipeline is configured.

### Verify
`curl -s http://localhost:3000 | grep -n 'tailwind'` shows Tailwind asset link.

---

## 5) Tailwind compiles but UI still looks unchanged

### Symptom
`tailwindcss:build` succeeds, file exists, but visual changes do not appear.

### Root Causes
1. Template used Bootstrap classes (`navbar`, `nav-link`) instead of Tailwind utilities.
2. Served CSS was stale from cached/digested assets.

### Fix
1. Replace Bootstrap classes with Tailwind utility classes.
2. Rebuild and clear stale assets if needed:

```bash
bundle exec rails tailwindcss:build
rm -rf tmp/cache/assets public/assets
bundle exec rails s
```

### Verify
1. Runtime HTML contains Tailwind classes.
2. Served `/assets/tailwind-*.css` contains those classes.

---

## 6) Missing `tailwind.config.js`

### Symptom
Concern that Tailwind is not working because `tailwind.config.js` does not exist.

### Reality
For `tailwindcss-rails` v4, config file is often optional for basic usage.

### Action
Treat as optional unless custom theme/plugins/safelist are needed.
