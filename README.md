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