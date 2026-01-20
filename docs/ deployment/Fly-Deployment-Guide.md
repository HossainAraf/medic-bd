Fly.io Deployment Guide for Rails API
Purpose

Document how to deploy a Rails API app on Fly.io, highlighting common pitfalls, fixes, and workflow recommendations.

1. Pre-requisites

Fly CLI (flyctl) installed and logged in

Docker installed (for local builds)

Rails API app ready with:

RAILS_MASTER_KEY

DATABASE_URL or Postgres ready

Optional: Fly free trial credit card for persistent VMs

2. Launching a Fly.io App
fly launch


Accept defaults unless you need to tweak:

App name (app = 'your-app-name')

Region

Fly will create:

fly.toml config file

Managed Postgres cluster if requested

Pitfall: Free trial VMs stop after 5 minutes — APIs will fail when idle.

3. Dockerfile for API-only Rails
FROM ruby:3.3.9-slim

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    libjemalloc2 \
    libyaml-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENV RAILS_ENV=production

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]


Notes / Pitfalls:

Yarn installation is not required for API-only Rails apps.

Node.js must be installed for Active Storage and JS runtime.

Always expose port 3000 and bind to 0.0.0.0.

4. Setting Secrets
fly secrets set RAILS_MASTER_KEY=$(cat config/master.key)
fly secrets set DATABASE_URL=your_postgres_url


Secrets are digested by Fly.io.

Required for Rails to start in production.

Pitfall: Missing RAILS_MASTER_KEY → app starts, but all API endpoints return 500.

5. Running Migrations
fly ssh console
bundle exec rails db:migrate
exit


Always run migrations after first deploy.

Verify tables exist:

bundle exec rails dbconsole
\dt


Pitfall: 500 errors from API endpoints are usually due to missing tables.

6. Deployment
fly deploy


Logs show build progress.

If errors occur, check:

Dockerfile dependencies

Ports (must listen on 0.0.0.0:3000)

ENV / secrets

Pitfall: Free trial VMs stop automatically → API endpoints unavailable until redeploy.

7. Logs and Debugging
fly logs


Look for:

ActiveRecord::NoDatabaseError

PG::UndefinedTable

Missing key

Use fly ssh console if machine is running to inspect app and run commands.

8. Postgres / Managed Database

Fly’s managed Postgres must be attached to app.

Use fly mpg status and fly mpg attach if necessary.

For permanent deployment, avoid ephemeral DBs.

✅ Summary of Pitfalls & Fixes
Issue	Cause	Fix
API endpoints 500	Tables not migrated	Run rails db:migrate inside Fly VM
App unreachable	Bound to localhost	Bind to 0.0.0.0:3000
Build fails	Missing dependencies	Add required libs to Dockerfile; remove apt-key for Yarn
Free trial stops	Fly VMs stop after 5 min	Add credit card or redeploy frequently
Secrets missing	Rails cannot decrypt credentials	fly secrets set RAILS_MASTER_KEY & DATABASE_URL