# Database configuration


This project uses PostgreSQL and expects all tables under the `medicbd` schema.

## 1. Create databases

```bash
bundle exec rails db:create
```

This creates:
- `medic_bd_dev` and `medic_bd_test`

## 2. Log in to PostgreSQL

Use one of the following (based on your local setup):

```bash
psql -U <your_db_user> -d medic_bd_dev -h localhost
```

or (socket/local peer auth):

```bash
psql -d medic_bd_dev
```

## 3. Run migrations

```bash
bundle exec rails db:migrate
```


## 4. Verify schema and table location (required)

First, confirm `medicbd` exists:

```sql
\dn
```

Expected output includes both `medicbd` and `public`.

Set schema path:

```sql
SET search_path TO medicbd;
```

Then confirm PostgreSQL search path:

```sql
SHOW search_path;
```

Expected output starts with `medicbd` (for example: `medicbd, public`).

Finally, verify app tables are in `medicbd` and not `public`:

```sql
SELECT to_regclass('medicbd.doctors') AS medicbd_doctors,
	   to_regclass('public.doctors') AS public_doctors;
```

Expected:
- `medicbd_doctors` is `medicbd.doctors`
- `public_doctors` is `NULL`

Optional full list check:

```sql
SELECT schemaname, tablename
FROM pg_tables
WHERE schemaname IN ('medicbd', 'public')
ORDER BY schemaname, tablename;
```

## 5. Optional checks

Dump schema:

```bash
bundle exec rails db:schema:dump
```

Quick Rails-side verification:

```bash
bundle exec rails runner "puts ActiveRecord::Base.connection.schema_exists?('medicbd')"
```

Expected: `true`

## Notes

- `config/database.yml` already sets `schema_search_path: medicbd, public`.
- `config/initializers/ensure_schema.rb` raises if `medicbd` does not exist.
- If you see `Required database schema 'medicbd' does not exist`, create the schema in `psql`, then run migrations again.
- If any app table appears in `public` (for example `public.doctors`), stop and fix `schema_search_path` before continuing.

