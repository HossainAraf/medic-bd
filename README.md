# MedicBD — Hybrid Rails (API + Full-Stack)

<a name="readme-top"></a>

<div align="center">

  <br/>

</div>

# 📗 Table of Contents

- [📖 About the Project](#about-project)

  - [🛠 Built With](#built-with)
    - [Key Features](#key-features)
    - [Project Evaluation](#project-evaluation)
    - [Architecture Overview](#architecture-overview)
- [💻 Getting Started](#getting-started)
  - [Setup](#setup)
  - [Branching-Strategy](#branching-strategy)
- [API-endpoints](#api-endpoints)
- [Pitfalls:Solved](#pitfalls)
- [🔭 Future Features](#future-features)
- [👥 Authors](#authors)
- [📝 License](#license)
- [🙏 Acknowledgements](#acknowledgements)
  
 ## About the project<a name="about-project"></a>
MedicBD is a hybrid Ruby on Rails application that started as an API-only backend and is now evolving into a full-stack Rails app using Hotwire & Tailwind.

# The project demonstrates:

- Clean API design with JWT authentication

- A safe transition from API-only → full-stack Rails

- Clear separation between API and Web layers

- Modern Rails 7 tooling (Hotwire, Tailwind, Importmap)

## 🛠 Built With:<a name="built-with"></a>
- Ruby on Rails
- PostgreSQl

# ✨ Key Features<a name="key-features"></a>

**API (v1)-**

- Doctors, Specializations, Chambers, Districts

- Filter doctors by specialization & district

- JWT-based authentication

- Designed for React / mobile clients

**Web (Full-Stack Rails)-**

- Server-rendered HTML (ERB)

- Hotwire (Turbo + Stimulus)

- Tailwind CSS

- Session-based authentication (planned)

## 📜 Project Evolution<a name="project-evaluation"></a>

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
<p align="right">(<a href="#readme-top">back to top</a>)</p>

🧱 Architecture Overview<a name="architecture-overview"></a>

Controller Separation (Core Design)

```text
ApplicationController < ActionController::Base
└── Web::BaseController
    ├── Web::HomeController
    └── Web::DoctorsController

Api::BaseController < ActionController::API
└── Api::V1::DoctorsController

Api::BaseController < ActionController::API </br>
└── Api::V1::DoctorsController # JSON / JWT


### Why This Matters
----------------------------------
Concern	    API	        Web
-----       -------    ---------------
State	    Stateless	Stateful
Auth	    JWT        	Session + Cookies
CSRF	    Not needed	Required
Views	    ❌	        ✅
```
#### This separation keeps:

-    API backward-compatible

-    Web layer free to evolve

-    Zero cross-contamination of concerns

🚀 Getting Started<a name="getting-started"></a> </br>

Ruby & Node check:
```
ruby --version
node --version
```
Install dependencies:
```
bundle install
npm install
```
Database setup: <a name="setup"></a>
```
rails db:create
rails db:migrate
rails db:fixtures:load
```

For specific environments:
```
RAILS_ENV=test rails db:create
RAILS_ENV=production rails db:migrate
```
▶️ Running the App
Development (Full-Stack)
```
bin/dev
```
**Important-
bin/dev runs Rails and the Tailwind build watcher.
rails s alone will NOT compile CSS.

API-only branches:
```
rails s
```
🧪 Running Tests:
```
rails test
```
<p align="right">(<a href="#readme-top">back to top</a>)</p>
🌿 Branching Strategy<a name="branching-strategy"></a>
```
Branch	                Purpose
dev	                    development branch
v1.0-api    	        Stable API-only snapshot
fullstack             	Hotwire + Tailwind work
main 	                Production-ready code
```
This allows:

-Safe experimentation
-API stability
-Clear evolution history

🔌 API Endpoints (v1): <a name="api-endpoints"></a>

Base URL:

http://127.0.0.1:3000/api/v1

Examples:
```
Endpoint	                    Method
/auth/login                     POST
/specializations	            GET
/doctors	                    GET/POST
/doctors/:id	                GET
/doctors/filtered_doctors	    GET
/chambers	                    GET
/districts	                    GET
```
👉 Full payload examples are documented in docs/api.md

⚠️ Common Pitfalls (Solved):<a name="pitfalls"></a>

Tailwind not updating?

Use:
bin/dev

Tailwind is build-time, not runtime.

JWT auth removed from ApplicationController?

Correct.

API auth belongs in Api::BaseController

Web uses sessions + CSRF

<p align="right">(<a href="#readme-top">back to top</a>)</p>
🔭 Future Roadmap<a name="future-features"></a>

-Shared service object for filtered_doctors

-Turbo-powered filters

-Stimulus carousel for doctor sliders

-Appointment booking (full-stack)

🧠 What This Project Demonstrates

✔ Rails controller inheritance mastery
✔ JWT vs session authentication knowledge
✔ Safe refactoring mindset
✔ Hotwire done intentionally, not blindly
✔ Production-quality thinking

👥 Authors:<a name="authors"></a>

**Md Arafat Hossain**

- GitHub: <a href="https://github.com/HossainAraf">HossainAraf </a>
- LinkedIn: <a href="https://linkedin.com/in/md-arafat-hossain-111403275"> Md. Arafat Hossain </a>

📄 License<a name="license"></a>
MIT License — see root/LICENSE.md

🙏 Acknowledgments<a name="acknowledgements"></a>

- Family support
- Microverse
  — structure, standards, and discipline
