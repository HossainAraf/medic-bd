# README



Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# Branching Strategy
dev (default branch):

    -All history lives here.

   - Day‑to‑day development, experiments, and feature branches merge back into dev.

v1.0-api branch (api-only):

    -Cut from dev at a stable point.

    -Preserves the API‑only version for demos, external clients (React/mobile), or anyone who wants to see a clean backend baseline.

fullstack branch:

    -Cut from api-only.

    -Dedicated to Hotwire/Tailwind work, evolving the app into a full‑stack product.

    <!-- -Tagged as v2.0-fullstack when stable. -->

-main (production branch)

    Receives merges from api-only or fullstack depending on what we want live.

    -Always reflects the production‑ready state.

    -Deployment pipelines point here.

# API endpoints (JSON):
API_BASE_URL = http://127.0.0.1:3000/api/v1

- FETCH specializations: ${API_BASE_URL}/specializations
  method: 'GET'

- FETCH CHAMBERS BY DISTRICT ID AND CHAMBER CATEGORY: ${API_BASE_URL}/chambers?category=${category}&district_id=${districtId}
  method: 'GET'

- FETCH FILTERED DOCTORS BY specialization ID AND district ID: {API_BASE_URL}/doctors/filtered_doctors?specialization_id=${specializationId}&district_id=${districtId}
  method: 'GET'

- FETCH DOCTORS BY specialization ID: ${API_BASE_URL}/doctors/filtered_doctors?specialization_id=${specializationId}
  method: 'GET'

- FETCH ALL DOCTORS: ${API_BASE_URL}/doctors
  method: 'GET'

- FETCH DOCTOR BY ID: ${API_BASE_URL}/doctors/${id}
  method: 'GET'

- FETCH DOCTOR BY ORDER: ${API_BASE_URL}/doctors/order/${order}
  method: 'GET'

- FETCH DISTRICTS: ${API_BASE_URL}/districts
  method: 'GET'

- ADD NEW DOCTOR: ${API_BASE_URL}/doctors
  method: 'POST'
  headers = {
    'Content-Type': 'application/json',
  }

- UPDATE DOCTOR: ${API_BASE_URL}/doctors/${doctor.id}
  method: 'PUT',

- FETCH Feedbacks: ${API_BASE_URL}/user_feedbacks
  method: 'GET'

- CREATE NEW Feedback: ${API_BASE_URL}/user_feedbacks
  method: 'POST'
  headers = {
    'Content-Type': 'application/json',
  }

- 
<!-- *** Case sensative category:Frontend form has this dropdown, so no worry if entry data using form. Otherwise must remember not to use other categories eg: 'diagnostics'  would create a new category and conflict/miss when filter-->
<!-- Fronend form -->
const AddDoctorForm = () => {
  const categories = [
    { id: 1, name: 'Diagnostic' },
    { id: 2, name: 'Clinic' },
    { id: 3, name: 'Hospital' },
    { id: 4, name: 'Private Chamber' },
  ];
--------------------------------------------

<!-- POST: api/v1/doctors -->
<!-- Not a good practice, rather we should us 'find' -->
{
  "doctor": {
    "name": "Tasnia Habib",
    "bangla_name": "তাসনিয়া হাবিব সিনথি",
    "specialty": "স্কেলিং, ফিলিং, রুট ক্যানেল, দাঁত বাঁধাই ও অন্যান্য",
    "qualification": "BDS, MPhil, PHD",
    "experience": "সহকারী অধ্যাপক, উদয়ন ডেন্টাল কলেজ, রাজশাহী",
    "order": 1800005,
    "photo_url": "",
    "special_notes": "প্রতি মাসের ১ম ও শেষ শুক্রবার ফ্রি চিকিৎসা সেবা দেয়া হয়",
    "description": "",
    "doctor_schedules_attributes": [
      {
        "available_day": "প্রতিদিন",
        "available_time": "বিকাল ৪ টা থেকে রাত ৮ টা",
        "contact": "01728-174202",
        "chamber_attributes": {
          "name": "শুভ ক্লিনিক",
          "category": "Clinic",
          "address": "চক এনায়েত, দয়ালের মোড়, নওগাঁ",
          "district_id": 1
        }
      }
    ]
  }
}
-----------------------------
-----------------
<!-- example payload for user 'sign up'  format-->
POST: 
route: /api/v1/medic_users
Content-Type: application/json
Accept: application/json (optional)

{
  "medic_user": {
    "name": "Araf",
    "email": "araf@example.com",
    "phone": "017xxxxxxxx",
    "password": "secret123",
    "password_confirmation": "secret123",
    "role": "admin"
  }
}
----------------------------------
--------------
<!-- example 'Log In' pay load format -->
POST
route: /api/v1/auth/login
Content-Type: application/json
Accept: application/json (optional)

{
  "medic_user": {
    "email": "<user email>",
    "password": "<user pass>"
  }
}
------------------------
--------
## Transformation of API-only app > Rails Fullstack:
- Controller architechture:

    ApplicationController
      ├── HomeController        (public)
      ├── PagesController       (public)
      └── Web::BaseController   (session auth)
            └── AdminController

    Api::BaseController
      └── Api::V1::DoctorsController (JWT auth)

# Flow
Full-stack side
- ApplicationController < ActionController::Base
API side
- Api::BaseController < ActionController::API

# why we removed API auth from ApplicationController to api base_controller: 
- API → stateless → JWT → Authorization header

- Web (Hotwire/HTML) → stateful → session + cookies + CSRF

# Controllers hierarchy
ApplicationController        # Web / HTML / Hotwire
  └── Web::BaseController    # (optional, but recommended)

Api::BaseController          # JSON / JWT


## Command (important distinction)

| Environment           | Command                                |
| --------------------- | -------------------------------------- |
| Development           | `bin/dev`                              |
| Production            | `rails assets:precompile` + app server |
| One-off backend debug | `rails s` (optional)     

What I actually demonstrated:

✔ Ability to reason about inheritance
✔ Understanding of Rails controller layers
✔ Knowing why JWT ≠ session auth
✔ Willingness to refactor instead of hacking

## **Dificulties faced and & how I overcome:**
  # Tailwind configuration:

Tailwind build step, Output CSS (app/assets/builds) were missing.
Solution: 
Add "cssbundling-rails" gem
run:
``bundle install``
``rails css:install:tailwind``

I was running the command `rails server`(❌) which does not compile tailwind watcher. The correct command to run dev server with tailwind is : `bin/dev` (✅).

beacuse, Tailwind in Rails is not a runtime library
It is a build-time compiler.


# Future features:
- Refactor filtered_doctors(specializations>districts>doctors atrributes with assocoations) logic of doctors_controler to a shared file to Reuse both in Api/BaseController & Web/BaseController.

- Stimulus controller for the slides so they auto‑rotate like a React carousel.


## 🔭Acknowledgments <a name="acknowledgements"></a>

- My Family.
- [Microverse Team](https://www.microverse.org/) for supportive documentations eg; linters, coding standard, gitflow etc.
- 

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FAQ (optional) -->

## ❓ FAQ <a name="faq"></a>

- **Are you using database?**

  - 

- **Can I use this project for personal use?**

  - 

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>