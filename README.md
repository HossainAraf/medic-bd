MedicBD — Hybrid Rails (API + Full-Stack)

MedicBD is a hybrid Ruby on Rails application that started as an API-only backend and is now evolving into a full-stack Rails app using Hotwire & Tailwind.

The project demonstrates:

Clean API design with JWT authentication

A safe transition from API-only → full-stack Rails

Clear separation between API and Web layers

Modern Rails 7 tooling (Hotwire, Tailwind, Importmap)

✨ Key Features
API (v1)

Doctors, Specializations, Chambers, Districts

Filter doctors by specialization & district

JWT-based authentication

Designed for React / mobile clients

Web (Full-Stack Rails)

Server-rendered HTML (ERB)

Hotwire (Turbo + Stimulus)

Tailwind CSS

Session-based authentication (planned)

## 📜 Project Evolution

This project was intentionally developed in phases:

### Phase 1 — API-Only Rails (v1)
- Rails API-only mode
- JWT authentication
- JSON endpoints for doctors, chambers, districts, and feedback
- Designed to support React and mobile clients
- Stable and production-ready

A snapshot of this stage is preserved in the `v1.0-api` branch.

### Phase 2 — Hybrid Rails (Current)
- Transitioned to full-stack Rails
- Introduced Web controllers alongside API controllers
- Added Hotwire (Turbo + Stimulus)
- Tailwind CSS for UI
- API v1 remains unchanged

🧱 Architecture Overview
Controller Separation (Core Design)
ApplicationController < ActionController::Base
└── Web::BaseController        # HTML / Sessions / CSRF
    ├── Web::HomeController
    └── Web::DoctorsController

Api::BaseController < ActionController::API
└── Api::V1::DoctorsController # JSON / JWT

Why This Matters
Concern	API	Web
State	Stateless	Stateful
Auth	JWT	Session + Cookies
CSRF	Not needed	Required
Views	❌	✅

This separation keeps:

API backward-compatible

Web layer free to evolve

Zero cross-contamination of concerns

🚀 Getting Started
Ruby & Node

Ruby: see .ruby-version

Node: see .node-version

Install dependencies
bundle install
npm install

Database setup
rails db:create
rails db:migrate
rails db:fixtures:load


For specific environments:

RAILS_ENV=test rails db:create
RAILS_ENV=production rails db:migrate

▶️ Running the App
Development (Full-Stack)
bin/dev


Important:
bin/dev runs Rails and the Tailwind build watcher.
rails s alone will NOT compile CSS.

API-only branches
rails s

🧪 Running Tests
rails test

🔌 API Endpoints (v1)

Base URL:

http://127.0.0.1:3000/api/v1


Examples:

Endpoint	Method
/specializations	GET
/doctors	GET
/doctors/:id	GET
/doctors/filtered_doctors	GET
/chambers	GET
/districts	GET
/user_feedbacks	GET / POST

👉 Full payload examples are documented in docs/api.md

🌿 Branching Strategy
Branch	Purpose
dev	Main development branch
v1.0-api	Stable API-only snapshot
fullstack	Hotwire + Tailwind work
main	Production-ready code

This allows:

Safe experimentation

API stability

Clear evolution history

⚠️ Common Pitfalls (Solved)
Tailwind not updating?

Use:

bin/dev


Tailwind is build-time, not runtime.

JWT auth removed from ApplicationController?

Correct.

API auth belongs in Api::BaseController

Web uses sessions + CSRF

🔭 Future Roadmap

Shared service object for filtered_doctors

Turbo-powered filters

Stimulus carousel for doctor sliders

Appointment booking (full-stack)

🧠 What This Project Demonstrates

✔ Rails controller inheritance mastery
✔ JWT vs session authentication knowledge
✔ Safe refactoring mindset
✔ Hotwire done intentionally, not blindly
✔ Production-quality thinking

📄 License

MIT License — see LICENSE

🙏 Acknowledgments

Family support

Microverse
 — structure, standards, and discipline
