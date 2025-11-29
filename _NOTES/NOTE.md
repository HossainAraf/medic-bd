----------------------------------------
----------
get in to shared databse using respective schema (here : medicbd )
SELECT * FROM medicbd.medic_users;
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
sslmode: require
-----------------------
--------------
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
  