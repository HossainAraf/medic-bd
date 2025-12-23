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
<!-- example payload for user sign up  format-->
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
<!-- example log in pay load format -->
{
  "medic_user": {
    "email": "<user email>",
    "password": "<user pass>"
  }
}
------
{
  "medic_user": {
    "email": "arafat.kd@gmail.com>",
    "password": "123456"
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

/controllers/application_controller.rb
- Use seperate ActionControllers: 
  class ApplicationController < ActionController::Base (fullstack)
  class ApplicationController < ActionController::API (api)
  class ApplicationController < ActionController::web (html)

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

  class ApplicationController < ActionController::Base
-----
  module Api
    class BaseController < ActionController::API
-----
  module Web
    class BaseController < ApplicationController
----
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

# 