#  Check Current Search Path:
-- Shows what schemas are searched and in what order
SHOW search_path;
-- Example output: search_path
-- medicbd, public

 # Check Current Active Schema:
-- Shows which schema you're currently working in
SELECT current_schema();
-- Example output: current_schema
-- medicbd
----------------------------------------
----------
#Log in to local DB
psql -U <userName> -d <databaseName>
------------------------------------
---------
<!-- Syntax to Connent to render databse   -->
**CAUTION: Must not push the original valuse by any developer**
# ~/.pg_service.conf.template
[mydb_render]
host=<YOUR_HOST>
port=5432
user=<YOUR_USER>
dbname=<YOUR_DB>
password=<YOUR_PASSWORD>
--------------------------------
---------

# Open the encrypted credentials file in VS Code
EDITOR="code --wait" rails credentials:edit
------------------------------
------

RAILS_ENV=production bundle exec rails db:migrate

<!-- Force update commit messege -->
[ flow: wrong commit messege > push commit   > amend  commit messege ] > 
git push --force-with-lease origin <branch_name>

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
# find_or_create_by! or similar methods for lookups to avoid duplicates.
<!-- POST: api/v1/doctors -->
<!-- Not a good practice, rather we should us 'find' -->
-----------------------------
----------------
<!-- {
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
} -->
{
  "doctor": {
    "name": "12-12Dr. John Smith",
    "bangla_name": "জন ",
    "display_order": 100001,
    "qualification": "MBBS, MD",
    "experience": "10 years",
    "specialty": "Cardiology",
    "special_notes": "Cardiologist",
    "description": "Expert in heart diseases",
    "photo_url": "example.com/jhhh87",
    "doctor_specializations_attributes": [ 
        { "specialization_id": 1 } 
        ]

  }
}
------
{
  "specialization": {

  "name": "Hematology"
  }
  
}
{
    "id": 14,
    "created_at": "2026-01-14T13:23:17.437Z",
    "name": "Hematology",
    "updated_at": "2026-01-14T13:23:17.437Z"
}
-----------------------------
-----------------
-----------------------------
-----------------
<!-- example payload for user sign up  format-->
{
  "medic_user": {
  "email": "Person-3@gmail.com",
  "name": "Arafat",
  "password": "",
  "role": "user"
  }
  --------------
  {
  "doctor_schedule": {
    "chamber_id": 2,
    "available_days": ["sunday","monday", "tuesday", "wednesday"],
    "slots": ["morning", "afternoon", "evening"],
    "times": {
      "morning": { "start": "07:00", "end": "09:30" },
      "evening": { "start": "17:00", "end": "20:00" },
      "afternoon": {"start": "15:00", "end": "17:30"}
    }
  }
}
---------------------------------
http://localhost:3000/api/v1/doctors/dr-bd-000001/doctor_schedules/bulk_update
{
  "doctor_schedule": {
    "chamber_id": 2,
    "available_days": ["sunday", "monday"],
    "slots": ["morning", "evening"],
    "times": {
      "morning": {"start": "07:00", "end": "09:30"},
      "evening": {"start": "17:00", "end": "21:00"}
    }
  }
}
------------------------
--------
EDITOR="code --wait" bin/rails credentials:edit --environment production
---------------------
-----------
<!-- detect and autocorrect rubocop linter -->
rubocop -A
-------------------
---------
<!-- TO DO  -->
# Added bangla_name to doictors controllers functions. Check where need where not
---------------------------------------
---------------------
In Ruby, the private keyword makes all methods defined after it private to the class. Private methods cannot be called as before_action callbacks.

When Rails tries to run the callback chain, it looks for the :authorize_admin method. Because it's marked as 
private
, Rails cannot find it in the list of available actions and fails.
----------------------------
-----------
# Rails + PostgreSQL Notes

## Table Name Prefix
- `self.table_name_prefix = 'md_'` in `ApplicationRecord` applies only to models that inherit from it.
- Existing migrations are unaffected; only new models will get prefixed tables.
- Explicit `self.table_name` overrides the prefix.
- Best practice: use prefix only for user/auth tables (e.g., `medic_users`).
[Note that, we removed prefix later]
## Database Setup
- Default PostgreSQL port: 5432 (Rails may try 5433 if misconfigured).
- Ensure `config/database.yml` matches credentials and port.
- Grant `CREATEDB` privilege to app user or create DB manually.

## Credentials
- `config/master.key` must match `credentials.yml.enc`.
- Comment out entire blocks in YAML, not just parent keys.
- Keep secrets scoped per environment (development, production).

## Associations
- Prefixed tables (like `medic_users`) need explicit associations when linking to unprefixed tables.

-------------------------------
--------------------------
## SEED example
## db/seeds.rb

# Seed :medic_users

puts "Seeding MedicUsers..."

def create_medic_user(attributes)
  user = MedicUser.find_or_initialize_by(email: attributes[:email])
  
  if user.new_record?
    user.assign_attributes(attributes)
    if user.save
      puts "✅ Created: #{user.name} (#{user.role}) - #{user.email}"
      return user
    else
      puts "❌ Failed: #{user.name} - #{user.errors.full_messages.join(', ')}"
      return nil
    end
  else
    puts "⏩ Exists: #{user.name} (#{user.role})"
    return user
  end
end

# Seed data
users = [
  {
    name: "Dr. John Smith",
    email: "john.smith@hospital.com",
    phone: "+1-234-567-8900",
    password: "Password123!",
    password_confirmation: "Password123!",
    role: "doctor"
  },
  {
    name: "Patient David Wilson",
    email: "david.wilson@example.com",
    phone: "+1-234-567-8906",
    password: "Patient123!",
    password_confirmation: "Patient123!",
    role: "patient"
  }
]

created_count = 0
users.each do |user_attrs|
  user = create_medic_user(user_attrs)
  created_count += 1 if user&.persisted?
end

puts "\n🎉 MedicUsers seeding completed!"
puts "Total users in database: #{MedicUser.count}"
puts "New users created: #{created_count}"
......................................
# Seed: District

puts"Seeding Districts..."

districts_data = [
  { name: "Naogaon" },
  { name: "Bogra" },
  { name: "Rajshahi" },
  { name: "Barishal" },

]
created_count = 0
districts_data.each do |district_attrs|
  district = District.find_or_initialize_by(name: district_attrs[:name])
  if district.persisted?
    if district.previously_new_record?
      created_count += 1
      puts "✅ Created district: #{district.name}"
    else
      puts "ℹ️ District already exists: #{district.name}"
    end  
  else
    if
      district.save
      created_count += 1
      puts "✅ Created district: #{district.name}"
    else
      puts "❌ Failed to create district: #{district.name}. Errors: #{district.errors.full_messages.join(', ')}"
    end  
  end
end
    puts "Seeding completed. Total districts created: #{created_count}"
    puts "Total districts in database: #{District.count}"
    
    ----------------------
   
    # Seed Specializations
    
  Specialization.create([{ name: 'হৃদরোগ' }, {name: 'জেনারেল মেডিসিন'}, { name: 'নিউরোলজিস্ট' }, {name: 'মানসিক রোগ'}, { name: 'অর্থোপেডিক/হার-জোড়'}, { name: 'গ্যাস্ট্রোএন্টারোলজিস্ট' }, { name: 'চর্ম ও যৌনরোগ'}, { name: 'এন্ডোক্রিনোলজিস্ট'}, { name: 'নেফ্রোলজিস্ট' }, { name: 'শিশুরোগ'}, {name:'স্ত্রীরোগ'}, { name: 'চক্ষু'}, { name: 'কান, নাক ও গলা'}])
----------------------------------------
UPDATE specializations
SET name = 'শিশুরোগ'
WHERE id = '10';
---------------
-----------------
# Connect to the Render DB
export DATABASE_URL="< external link of render db>"
psql $DATABASE_URL
------------------------
--------------
# Skip for Future 
'sslmode: require' in darabase.yml/production env
We remove it for now, because:
 We could sedd data in render DB, & data can be retrived from Database in terminal but when try to retrive from POSTMAN/frontednd GET request it shows [] (black array)  
 ----------------
 --------------
<<<<<<< HEAD
=======
 # UI -plan For FullStack Rails
medic-bd-api/
├── app/
│   ├── assets/
│   │   ├── builds/                           # Compiled assets (from esbuild/webpack)
│   │   │   ├── application.js
│   │   │   └── application.css
│   │   ├── config/
│   │   │   └── manifest.js                   # Sprockets manifest
│   │   ├── images/                           # Static images
│   │   │   ├── logo.png
│   │   │   └── favicon.ico
│   │   └── stylesheets/                      # Source CSS files
│   │       ├── application.tailwind.css      # Tailwind entry point
│   │       └── custom/                       # Custom CSS if needed
│   │           └── components.css
│   │
│   ├── channels/                             # Action Cable/WebSocket
│   │   ├── application_cable/
│   │   │   ├── channel.rb
│   │   │   └── connection.rb
│   │   └── notifications_channel.rb          # Example channel
│   │
│   ├── controllers/                          # Rails controllers
│   │   ├── application_controller.rb
│   │   ├── concerns/
│   │   │   └── turbo_streamable.rb           # Turbo Stream concerns
│   │   ├── api/                              # API controllers if needed
│   │   │   └── v1/
│   │   │       └── base_controller.rb
│   │   └── pages_controller.rb               # Example controller
│   │
│   ├── helpers/                              # View helpers
│   │   ├── application_helper.rb
│   │   ├── turbo_stream_helper.rb            # Custom Turbo helpers
│   │   └── stimulus_helper.rb                # Stimulus attribute helpers
│   │
│   ├── javascript/                           # ⭐ NEW Rails 7 location
│   │   ├── application.js                    # JavaScript entry point
│   │   ├── controllers/                      # Stimulus controllers
│   │   │   ├── application.js                # Stimulus app setup
│   │   │   ├── index.js                      # Autoload controllers
│   │   │   ├── hello_controller.js           # Example controller
│   │   │   ├── modal_controller.js           # Modal controller
│   │   │   ├── form_controller.js            # Form handling
│   │   │   ├── dropdown_controller.js        # Dropdown menu
│   │   │   └── clipboard_controller.js       # Copy to clipboard
│   │   │
│   │   ├── channels/                         # Action Cable consumer
│   │   │   └── consumer.js
│   │   │
│   │   ├── custom/                           # Custom JavaScript modules
│   │   │   ├── utilities.js
│   │   │   ├── notifications.js
│   │   │   └── analytics.js
│   │   │
│   │   └── lib/                              # JavaScript libraries
│   │       └── stimulus-notification.js
│   │
│   ├── models/                               # ActiveRecord models
│   │   ├── application_record.rb
│   │   ├── concerns/
│   │   │   └── searchable.rb
│   │   ├── user.rb
│   │   ├── post.rb
│   │   └── comment.rb
│   │
│   ├── views/                                # View templates
│   │   ├── layouts/
│   │   │   ├── application.html.erb          # Main layout
│   │   │   ├── mailer.html.erb
│   │   │   └── mailer.text.erb
│   │   │
│   │   ├── shared/                           # Shared partials
│   │   │   ├── _flash.html.erb               # Flash messages
│   │   │   ├── _navbar.html.erb              # Navigation
│   │   │   ├── _footer.html.erb              # Footer
│   │   │   ├── _sidebar.html.erb             # Sidebar
│   │   │   └── _modal.html.erb               # Modal template
│   │   │
│   │   ├── components/                       # View Components (optional but recommended)
│   │   │   ├── button_component.rb
│   │   │   ├── button_component.html.erb
│   │   │   ├── card_component.rb
│   │   │   └── card_component.html.erb
│   │   │
│   │   ├── turbo_stream/                     # Turbo Stream templates
│   │   │   ├── _flash.turbo_stream.erb       # Flash updates
│   │   │   ├── _create.turbo_stream.erb      # Generic create
│   │   │   ├── _update.turbo_stream.erb      # Generic update
│   │   │   ├── _destroy.turbo_stream.erb     # Generic destroy
│   │   │   └── _notification.turbo_stream.erb
│   │   │
│   │   ├── pages/                            # Controller views
│   │   │   ├── home.html.erb
│   │   │   └── about.html.erb
│   │   │
│   │   └── users/                            # Resource views
│   │       ├── index.html.erb
│   │       ├── show.html.erb
│   │       ├── new.html.erb
│   │       ├── edit.html.erb
│   │       ├── _form.html.erb                # Form partial
│   │       ├── _user.html.erb                # User partial
│   │       └── turbo_stream/                 # User-specific Turbo Streams
│   │           ├── create.turbo_stream.erb
│   │           └── update.turbo_stream.erb
│   │
│   ├── mailers/                              # Action Mailer
│   │   ├── application_mailer.rb
│   │   └── user_mailer.rb
│   │
│   └── jobs/                                 # Active Job
│       ├── application_job.rb
│       └── notification_job.rb
│
├── config/
│   ├── environments/
│   │   ├── development.rb
│   │   ├── production.rb
│   │   └── test.rb
│   │
│   ├── initializers/
│   │   ├── assets.rb                        # Asset pipeline config
│   │   ├── content_security_policy.rb       # CSP for Turbo/WebSocket
│   │   ├── filter_parameter_logging.rb
│   │   ├── inflections.rb
│   │   ├── permissions_policy.rb
│   │   ├── turbo.rb                         # Turbo-specific config
│   │   └── stimulus.rb                      # Stimulus config (if needed)
│   │
│   ├── locales/                             # Internationalization
│   │   ├── en.yml
│   │   └── bn.yml
│   │
│   ├── cable.yml                            # Action Cable config
│   ├── database.yml
│   ├── environment.rb
│   ├── importmap.rb                         # ⭐ Import maps config (if using)
│   ├── puma.rb
│   ├── routes.rb                            # Routes with Turbo concerns
│   └── storage.yml                          # Active Storage
│
├── db/
│   ├── migrate/
│   │   ├── 20240101000000_create_users.rb
│   │   ├── 20240101000001_create_posts.rb
│   │   └── 20240101000002_add_turbo_columns.rb
│   ├── schema.rb
│   ├── seeds.rb                             # Seed data with Turbo examples
│   └── structure.sql
│
├── lib/
│   ├── assets/                              # Library assets
│   ├── tasks/                               # Rake tasks
│   │   ├── turbo.rake                       # Turbo-related tasks
│   │   └── assets.rake
│   └── turbo_helper.rb                      # Custom Turbo helpers
│
├── test/                                    # or spec/ for RSpec
│   ├── controllers/
│   │   └── pages_controller_test.rb
│   ├── models/
│   │   └── user_test.rb
│   ├── system/                              # System tests (great for Turbo!)
│   │   ├── application_system_test_case.rb
│   │   ├── navigation_test.rb
│   │   └── turbo_stream_test.rb
│   ├── test_helper.rb
│   └── fixtures/
│       └── users.yml
│
├── vendor/                                  # 3rd party assets
│   └── javascript/                          # Downloaded JS libraries
│
├── storage/                                 # Active Storage files
│   └── uploads/
│
├── tmp/
│   ├── cache/
│   ├── pids/
│   └── sockets/                             # Action Cable sockets
│
├── public/
│   ├── 404.html
│   ├── 422.html
│   ├── 500.html
│   ├── robots.txt
│   └── vite/                                # If using Vite
│
├── .gitignore
├── .ruby-version
├── .node-version                           # Node version for Tailwind
├── .tool-versions                          # If using asdf
├── .env.example                            # Environment variables
├── .env.local
│
├── Gemfile
├── Gemfile.lock
│
├── package.json                            # Node dependencies
├── package-lock.json
│
├── tailwind.config.js                      # Tailwind configuration
├── postcss.config.js                       # PostCSS configuration
│
├── Procfile                                # Production process file
├── Procfile.dev                            # Development processes
│
├── README.md
├── Rakefile
└── config.ru
----------------------------
-----------
# Home/index:
      <%= render "home/card", title: "Chambers", path: chambers_path, icon: "🏥" %>
      <%= render "home/card", title: "Doctors", path: doctors_path, icon: "👨‍⚕️" %>
      <%= render "home/card", title: "Appointments", path: new_appointment_path, icon: "📅" %>
      <%= render "home/card", title: "Diagnostics", path: diagnostics_chambers_path, icon: "🧪" %>
      <%= render "home/card", title: "Hospitals", path: hospitals_chambers_path, icon: "🏨" %>
      ------------------
    #  _nav:
    
      <% link_to "MedicBd", root_path, class: "navbar-brand" %>
  <ul class="navbar-nav">
    <li class="nav-item">
      <%= link_to "Home", root_path, class: "nav-link" %>
    </li>
    <li class="nav-item">
      <%= link_to "Home", root_path, class: "nav-link" %>
    </li>
    <li class="nav-item">
      <%= link_to "diagnostics", root_path, class: "nav-link" %>
    </li>
    <li class="nav-item">
      <%= link_to "clinics-and-hospitals", root_path, class: "nav-link" %>
    </li>
    <li class="nav-item">
      <%= link_to "About", about_path, class: "nav-link" %>
    </li>
    <li class="nav-item">
      <%= link_to "Contact", contact_path, class: "nav-link" %>
    </li>
-----------
----------
# Install Tailwind
``
./bin/bundle add tailwindcss-rails

``
[ref:]:( https://github.com/rails/tailwindcss-rails)
------------
---------

**Essention tasks to convert api-only > fullstack**

# Use Base in actionController
- visual map of your controller inheritance hierarchy:
  ApplicationController → Web::BaseController
  ActionController::API → Api::BaseController → Api::V1::DoctorsController


# Update config/application.rb
    config.time_zone = "Central Time (US & Canada)"
    config.eager_load_paths << Rails.root.join("extras")
      <!-- comment out api-only -->
    # config.api_only = true

    # Enable the asset pipeline
    config.assets.enabled = true
    config.assets.version = '1.0'

# Install Missing JavaScript/CSS Bundling
  ``
  bin/rails importmap:install
  ``
# Add Views

# Add  Missing Helpers Directory

# Add CSRF Protection in application_controller
   protect_from_forgery with: :exception
   
   OR

   -if using API + views hybrid:

  protect_from_forgery with: :null_session, if: -> { request.format.json? }

# Update Strong Parameters (if requre) in controllers:

# Missing View Templates in controllers:

  rails generate erb:scaffold <Contollername>

  eg; 
  rails generate erb:scaffold User name:string email:string

#  Turbo/Stimulus Issues:

- Install Turbo/Stimulus if needed

``
rails turbo:install
rails stimulus:install
``

# Session Store Configuration:

# Authentication/Authorization

  We were using API tokens, need to add session-based auth

  Use Devise for authentication if needed
  Add to Gemfile: gem 'devise'
  Then run:
  rails generate devise:install
  rails generate devise User

  # Quick Diagnostic Commands:

      # Check what middleware is loaded
    rails middleware

    # Check if assets are compiling
    rails assets:precompile

    # Clear any cached files
    rails tmp:clear

# Share logic between API and HTML endpoints:
  Approach 1: Service Objects/Interactors
  Approach 2: Shared Base Controller with Responders(custom)
  Approach 3: Concerns for Shared Logic
  Approach 4: Use responders Gem
  Approach 5: API-Only Namespace with HTML Fallback
  Approach 6: Decorators/Presenters

Slected Appraoch: 5
  Advantage: 
  - API stays untouched
  - HTML grows naturally
  - Zero breakage risk

  Implementation:

  Create 1 base_controller and then split the behavior for API & Web:
  *controller inheritance hierarchy*
    ApplicationController → Web::BaseController→<specificContoller>
    ActionController::API → Api::BaseController→<specificContoller>

ActionController (module)
├── Base (full-featured)
│    └── ApplicationController (your main web root)
│          └── Web::BaseController (web-specific)
│
└── API (lightweight)
     └── Api::BaseController (API-specific)
          └── Api::V1::DoctorsController

  ----

  class ApplicationController < ActionController::Base
-----
  module Api
    class BaseController < ActionController::API
-----
  module Web
    class BaseController < ApplicationController
----
<!-- Rails has one ActionController module, but multiple subclasses
module ActionController
  class Base
    # full-featured controller for HTML, sessions, layouts, cookies, CSRF
  end

  class API < Base
    # lightweight subclass optimized for APIs
  end
end

Key points

ActionController::Base → full Rails controller

Includes: layouts, helpers, sessions, flash, cookies, CSRF protection, all middleware stack

ActionController::API → inherits from Base, but strips most middleware & helpers

Lightweight → fast JSON APIs

No views, no cookies, no CSRF by default

So Rails has one module (ActionController) but two controller classes you choose from.

class ApplicationController < ActionController::Base
This is the main full-stack controller

Handles HTML, sessions, CSRF protection

Base for all web controllers

module Api
  class BaseController < ActionController::API
  end
end
This is pure API

Inherits from ActionController::API (which itself inherits from Base internally)

Lightweight → no middleware like cookies, no layouts, no views

Fast for JSON requests

module Web
  class BaseController < ApplicationController
  end
end
This is your web-specific base

Inherits from your ApplicationController

Can add protect_from_forgery, before_action :authenticate_user!, layout etc.

Keeps your web controllers isolated from API controllers
 -->
# Folder Srtucture: 
    app/controllers/
      api/
        v1/
          doctors_controller.rb
          specifications_controller.rb
      web/
        doctors_controller.rb
        home_controller.rb

# Routes structure:

    Rails.application.routes.draw do
      root "web/home#index"

      namespace :web do
        resources :doctors, only: [:index, :show]
      end

      namespace :api do
        namespace :v1 do
          resources :doctors
          resources :specifications
        end
      end
    end

# ✅ Tailwind configuration
# ✅ Nav-UI basic
# ✅ Refactor filtered_doctors(specializations>districts>doctors atrributes with assocoations) logic of doctors_controler to a shared file to Reuse both in Api/BaseController & Web/BaseController.
# ✅ Test: MedicUser model: ❌ No FK
# NEXT ACTION:
Test: 
-✅ Specialization model:	❌ No FK
-✅ District model: ❌ No FK

- Update: Specialization model in foroward branch(webcore) as in testing branch.
---------------
-------
## Future plan to enhace testing:
- we can add a factory-style helper to avoid repetition
- refactor tests for speed & clarity
==================
DELETE FROM doctors
WHERE id = 9; 
===============
Do NOT try to fully solve human identity at DB level:
because Same name and bangla_name may have diffent doctros and may have same specializations. Same doctor may practicein different chambers of same district or different district.
-------------------
<!-- NEXT:  -->
for preventing wrong data-entry:
- Canonicalization (normalization) at model level
```
 before_validation :normalize_name

  private

  def normalize_name
    self.name = name
      &.strip
      &.squeeze(" ")
      &.downcase
  end
  ```
  ------------
Send Test messege if Doctor.name+Doctor.bangla_name+Specialization same to verify if this is intentional! Not prevented form DB layer, because it may exists in real world.
---------------------
  doctors.phone is operationally important

Recommendation
🟡 Keep nullable for now, but:

Validate format when present

Consider future NOT NULL when business matures

validates :phone,
  allow_nil: true,
  format: { with: /\A01\d{9}\z/, message: "invalid BD phone" }
===========================

## Adding slug for doctors unique identity 

```
before_validation :set_slug, on: :create

private

def set_slug
self.slug ||= format("dr-bd-%06d", id || (Doctor.maximum(:id).to_i + 1))
end
  ````
  --------------------

  email, name, role -  null:false

# ================
** ?? Same nested entity post can be added:
POST: /doctors
(slug is available)
# ================
**model-level referential protection** 
- dependent: :restrict_with_error 
Why restrict_with_error instead of others?:

```
| Option                     | Behavior                         |
| -------------------------- | -------------------------------- |
| `:destroy`                 | Cascades delete (dangerous)      |
| `:delete_all`              | Skips callbacks (very dangerous) |
| `:nullify`                 | Breaks integrity                 |
| `:restrict_with_exception` | Raises exception                 |
| `:restrict_with_error`     | Safe + user-friendly             |
```
=========================
| Action | Route                                         |
| ------ | --------------------------------------------- |
| List   | `GET /api/v1/doctors/:slug/doctor_schedules`  |
| Create | `POST /api/v1/doctors/:slug/doctor_schedules` |
| Show   | `GET /api/v1/doctor_schedules/:id`            |
| Update | `PATCH /api/v1/doctor_schedules/:id`          |
| Delete | `DELETE /api/v1/doctor_s
What to lock in mentally (important)

accepts_nested_attributes_for
→ enables assignment only

validates ..., presence: true
→ enforces business rules

permit(...) typo
→ causes intentional silent drop

When all three align, behavior is predictable.
==================================
## Why Option 1 wins (comparison):
```   
  Option	              Business Friendly	  Speed	      Risk	     Reversible
  1. Slug idempotency	  ⭐⭐⭐⭐	          ⭐⭐⭐⭐⭐	Low	       ✅
  2. Admin search flow	⭐⭐⭐⭐⭐	         ⭐⭐	      Very low	 ✅
  3. Composite identity	⭐	                 ⭐	        High      ❌
```

Final decision (locked recommendation)

Choose Option 1 now.

Document it as:

“Temporary idempotent doctor creation using slug. Subject to replacement by admin-driven identity resolution.”

That makes the decision:

Conscious

Explicit

Reversible
===================================
## What default: '' actually does

The default is not for “now”; it’s for failure-proofing the migration itself.
What default: '' actually does
add_column :chambers, :contact, :string, null: false, default: ''


This guarantees:

Existing rows get ''

Migration never fails

Constraint is enforced immediately

Then you can still enforce correctness at the application level:

validates :contact, presence: true


Rails treats '' as blank → validation fails on bad input.

Why we later remove the default (optional but clean)

After data is stable:

change_column_default :chambers, :contact, nil


Result:

DB enforces NOT NULL

App enforces presence

No silent empty values going forward

This is the Rails-recommended two-step hardening pattern.

When you can safely skip default: ''

You may skip it only if all are true:

DB is empty

No seeds yet

Single developer

No CI

You accept migration fragility

That’s usually a temporary state, not a guarantee.

Bottom line

Defaults in migrations are about reliability, not data quality.

Even with a “new” database, defensive migrations prevent future breakage.
Mental model to keep (simple rule)

When adding a column:

Ask: “Can old rows exist without this?”

If yes → default: '' or temporary default

Enforce correctness in model

Tighten DB later if needed

You applied this instinctively — that’s progress, not luck.
==================================


===================================
NEXT (after tested all works fine):
Hardening (Optional but Recommended) (optimiazation)

Do these only after everything above is stable:

DB CHECK (end_time > start_time)

Time-range overlap prevention (not just slot-based)

Read-only public schedule endpoint

Soft deletes or effective date ranges (future-proofing)
========================
