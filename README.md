MedicBD — Hybrid Rails (API + Full-Stack)

<a name="readme-top"></a>

<div align="center"> <br/> </div>
📗 Table of Contents

📖 About the Project

🛠 Built With

Key Features

Project Evolution

Architecture Overview

💻 Getting Started

Setup

Branching Strategy

API Endpoints

⚠️ Common Pitfalls (Solved)

🔭 Future Roadmap

👥 Authors

📝 License

🙏 Acknowledgements

About the Project <a name="about-project"></a>

MedicBD is a hybrid Ruby on Rails application. It started as an API-only backend and now is evolving into a full-stack Rails app using Hotwire and Tailwind.

This project demonstrates:

Clean API design (v1) with JWT authentication

Hybrid Rails approach with clear separation of API and Web layers

Safe transition from API-only → full-stack Rails

Modern Rails 7 tooling: Hotwire, Tailwind, Importmap

Production-ready thinking and maintainable architecture

🛠 Built With <a name="built-with"></a>

Ruby on Rails 7

PostgreSQL

Hotwire (Turbo + Stimulus)

Tailwind CSS

✨ Key Features <a name="key-features"></a>

API (v1)

Doctors, Specializations, Chambers, Districts

Filter doctors by specialization & district

Bulk update doctor schedules via service objects

JWT-based authentication

Designed for React / mobile clients

Web (Full-Stack Rails)

Server-rendered HTML (ERB)

Hotwire (Turbo + Stimulus)

Tailwind CSS

Session-based authentication (planned)

📜 Project Evolution <a name="project-evaluation"></a>
Phase 1 — API-Only Rails (v1)

Rails API-only mode

JWT authentication

JSON endpoints for doctors, chambers, districts, and feedback

Designed for React and mobile clients

Stable and production-ready

Snapshot preserved in v1.0-api branch.

Phase 2 — Hybrid Rails (Current)

Transitioned to full-stack Rails

Added Web controllers alongside API controllers

Hotwire (Turbo + Stimulus) for UI interactivity

Tailwind CSS styling

API v1 endpoints remain unchanged and backward-compatible

<p align="right">(<a href="#readme-top">back to top</a>)</p>
🧱 Architecture Overview <a name="architecture-overview"></a>

Controller Separation:

ApplicationController < ActionController::Base
└── Web::BaseController
    ├── Web::HomeController
    └── Web::DoctorsController

Api::BaseController < ActionController::API
└── Api::V1::DoctorsController


Key Differences

Concern	API	Web
State	Stateless	Stateful
Auth	JWT	Session + Cookies
CSRF	Not needed	Required
Views	❌	✅

This separation ensures:

API backward-compatibility

Web layer evolution without cross-contamination

🚀 Getting Started <a name="getting-started"></a>

Check Ruby & Node:

ruby --version
node --version


Install dependencies:

bundle install
npm install

Database Setup <a name="setup"></a>
rails db:create
rails db:migrate
rails db:fixtures:load


For specific environments:

RAILS_ENV=test rails db:create
RAILS_ENV=production rails db:migrate

Running the App

Development (Full-Stack)

bin/dev


Important: bin/dev runs Rails + Tailwind watcher.
rails s alone will not compile CSS.

API-only branches

rails s

Running Tests
rails test

<p align="right">(<a href="#readme-top">back to top</a>)</p>
🌿 Branching Strategy <a name="branching-strategy"></a>
Branch	Purpose
dev	Development branch
v1.0-api	Stable API-only snapshot
fullstack	Hotwire + Tailwind work
main	Production-ready code

This allows:

Safe experimentation

API stability

Clear project evolution history

🔌 API Endpoints (v1) <a name="api-endpoints"></a>

Base URL:

http://127.0.0.1:3000/api/v1


Examples:
```
| Endpoint                                      | Method | Description                                                          |
| --------------------------------------------- | ------ | -------------------------------------------------------------------- |
| `/doctors/:slug/doctor_schedules`             | POST   | Create a new schedule for a doctor. `:slug` refers to `doctor.slug`. |
| `/doctors/:slug/doctor_schedules/bulk_update` | PATCH  | Bulk update schedules for a doctor. `:slug` refers to `doctor.slug`. |
```

Full payload examples are documented in docs/api.md.

⚠️ Common Pitfalls (Solved) <a name="pitfalls"></a>

Tailwind not updating? → Always use bin/dev

JWT auth removed from ApplicationController → API auth belongs in Api::BaseController

Web layer uses sessions + CSRF

<p align="right">(<a href="#readme-top">back to top</a>)</p>
🔭 Future Roadmap <a name="future-features"></a>

Shared service objects for filtered doctors

Turbo-powered filters

Stimulus carousel for doctor sliders

Appointment booking (full-stack)

🧠 What This Project Demonstrates

Rails controller inheritance mastery

JWT vs session authentication knowledge

Safe refactoring mindset

Hotwire implemented intentionally

Production-quality thinking

👥 Authors <a name="authors"></a>

Md Arafat Hossain

GitHub: HossainAraf

LinkedIn: Md. Arafat Hossain

📄 License <a name="license"></a>

MIT License — see LICENSE.md

🙏 Acknowledgements <a name="acknowledgements"></a>

Family support

Microverse — structure, standards, and discipline