MedicBD — Hybrid Rails (API + Full-Stack)

<a name="readme-top"></a>

<div align="center"> <br/> </div>

## 📖 About the Project
MedicBD is a hybrid Ruby on Rails application that started as an API-only backend and is now expanding into a fullstack experience.

The current codebase keeps the API stable while the web layer grows in small, safe slices. At the moment, the web side includes the home page and the specializations index, while the broader doctor and chamber SSR work is tracked in the transition plan.

This project focuses on:

- Clean API design for v1 with JWT authentication.
- A clear separation between API and web controllers.
- A safe transition from API-only Rails to a fullstack Rails app.
- Modern Rails 8 tooling with Tailwind CSS and Hotwire-ready structure.

## 🔗 Live Links
- [Render](https://medic-bd-api.onrender.com/)
- [Fly](https://medic-bd-api-late-cherry-5634.fly.dev/)

## 🛠 Built With
- Ruby on Rails 8.1.1
- PostgreSQL
- Tailwind CSS
- Hotwire-ready Rails structure
- JWT authentication for the API layer
- Rails test framework

## 📚 Current Scope
- API v1 resources for doctors, chambers, districts, specializations, doctor schedules, medic users, and auth login.
- Web routes for the home page and specializations listing.
- API controllers that enforce JWT authentication in `Api::BaseController`.
- Web controllers that use `Web::BaseController` with CSRF protection and the `web` layout.
- Transition planning for SSR doctor and chamber pages in [docs/fullstack-transition-plan.md](docs/fullstack-transition-plan.md).

## 🧱 Architecture Overview
The app keeps the API and web layers separate:

```text
ApplicationController < ActionController::Base
├── Web::BaseController
│   ├── Web::HomeController
│   └── Web::SpecializationsController
└── Api::BaseController < ActionController::API
    ├── Api::V1::SessionsController
    ├── Api::V1::DoctorsController
    ├── Api::V1::ChambersController
    ├── Api::V1::DistrictsController
    ├── Api::V1::SpecializationsController
    ├── Api::V1::DoctorSchedulesController
    ├── Api::V1::MedicUsersController
    └── Api::V1::UserFeedbacksController
```

The practical difference is simple:

- API: stateless, JWT-based, JSON responses.
- Web: server-rendered HTML, sessions/cookies, CSRF protection.

This separation keeps `/api/v1` backward-compatible while the web layer evolves.

## 💻 Getting Started
### ⚙️ Setup
Install dependencies:

```bash
bundle install
```

Create and prepare the database:

```bash
bundle exec rails db:create
bundle exec rails db:migrate
```

If you need a fresh test database, run:

```bash
RAILS_ENV=test bundle exec rails db:create
RAILS_ENV=test bundle exec rails db:migrate
```

### 🛠 Development
Check your Ruby version first:

```bash
ruby --version
```

Start the app with the development process runner:

```bash
bin/dev
```

`bin/dev` runs the Rails server and the Tailwind watcher together. If you run `bin/rails s` directly, CSS will not rebuild automatically.

### ✅ Testing
Run the test suite:

```bash
bundle exec rails test
```

Run linting:

```bash
bundle exec rubocop --color
```

## 🌿 Branching Strategy
Current branch flow follows the transition plan in [docs/branching_strategy.md](docs/branching_strategy.md):

- `main` for production-ready code.
- `epic/fullstack-foundation` for the foundation work.
- `feat/fullstack-mvp` for the long-running integration branch.
- `feat/fullstack-<feature>` for small vertical slices.
- `release/fullstack-m<milestone>` or `release/fullstack-mvp` for release cuts.
- `hotfix/<scope>-<short-description>` for urgent fixes.

## 🔌 API Endpoints
The API base URL is:

```text
http://127.0.0.1:3000/api/v1
```

Current v1 routes include:

- `POST /api/v1/auth/login`
- `GET /api/v1/doctors`
- `GET /api/v1/doctors/:slug`
- `GET /api/v1/doctors/:slug/doctor_schedules`
- `POST /api/v1/doctors/:slug/doctor_schedules`
- `PATCH /api/v1/doctors/:slug/doctor_schedules/bulk_update`
- `GET /api/v1/chambers`
- `GET /api/v1/districts`
- `GET /api/v1/specializations`
- `GET /api/v1/specializations/:id`
- `GET /api/v1/specializations/:id/doctors`

## ⚠️ Common Pitfalls
- Use `bin/dev` during web development so Tailwind recompiles correctly.
- Keep JWT authentication inside `Api::BaseController`; do not move it into `ApplicationController`.
- Keep web-only behavior in `Web::BaseController` so CSRF and layout handling stay isolated.
- If the database schema is missing or migrations fail, review [docs/setup.md](docs/setup.md) before changing the app config.

## 🔭 Roadmap
The active transition plan is documented in [docs/fullstack-transition-plan.md](docs/fullstack-transition-plan.md). The next high-value steps are the SSR doctor pages, SEO metadata, and the booking flow.

## 📖 Documentation
- [Branching strategy](docs/branching_strategy.md)
- [Database setup](docs/setup.md)
- [Fullstack transition plan](docs/fullstack-transition-plan.md)
- [Language and naming conventions](docs/language-and-naming-v1.md)

## 👥 Authors
**Md Arafat Hossain**

- GitHub: [HossainAraf](https://github.com/HossainAraf)
- LinkedIn: [Md. Arafat Hossain](https://linkedin.com/in/md-arafat-hossain-111403275)

## 📝 License
MIT License. See [LICENSE](LICENSE).

## 🙏 Acknowledgements
- Family support.
- Microverse for structure, standards, and discipline.