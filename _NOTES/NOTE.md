RAILS_ENV=production bundle exec rails db:migrate


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