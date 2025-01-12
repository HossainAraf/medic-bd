# # ADD SPECIALIZATIONS
# names = ['গ্যাস্ট্রোলজিস্ট', 'রেডিওলজিস্ট']

# names.each do |name|
#   specialization = Specialization.create(name: name)
#   if specialization.persisted?
#     puts "Specialization created: #{specialization.name}"
#   else
#     puts "Specialization creation failed for #{name}."
#   end
# end

# doctor = Doctor.create(
#   name: 'মোঃ মামুনুর রশীদ',
#   specialty: 'চর্ম, অ্যালার্জি, চুল, নখ, যৌন রোগ বিশেষজ্ঞ ও লেজার সার্জন',
#   qualification: 'এমবিবিএস, বিসিএস (স্বাস্থ্য), ডিডিভি (চর্ম ও যৌন), থাইল্যান্ড',
#   experience: 'সহকারী পরিচালক,  জাতীয় হৃদরোগ ইন্সটিটিউট, ঢাকা',
#   order: 700007
# )
# doctor = Doctor.create(
#   name: 'মোঃ এস এম শামসুজ্জোহা',
#   specialty: 'চর্ম, অ্যালার্জি ও যৌন রোগ বিশেষজ্ঞ',
#   qualification: 'এমবিবিএস, বিসিএস (স্বাস্থ্য), ডিডিভি (বিএসএমএমইউ)',
#   experience: 'কনসালটেন্ট (চর্ম ও যৌন),  সদর হাসপাতাল, নওগাঁ',
#   order: 700017
# )
# doctor = Doctor.create(
#   name: 'মোঃ রইস উদ্দিন',
#   specialty: 'হৃদরোগ ও মেডিসিন বিশেষজ্ঞ',
#   qualification: 'এমবিবিএস, এফসিপিএস (মেডিসিন), এমডি (কারডিওলজি), WHO ফেলো ইন্টারভেনশনাল কারডিওলজি(মাদ্রাজ ও কোচিন-ভারত, মালয়েশিয়া)',
#   experience: 'অধ্যাপক ও বিভাগীয় প্রধান (হৃদরোগ),  রাজশাহী মেডিকেল কলেজ ও হাসপাতাল',
#   order: 700005
# )
# if doctor.persisted?
#   puts "Doctor created: #{doctor.name}"
# else
#   puts "Doctor creation failed: #{doctor.errors.full_messages.join(', ')}"
# end

# CREATE DISTRICTS
# districts = ['Naogaon', 'Rajshahi', 'Bogura']
# districts.each do |district|
#   district = District.create(name: district)
#   if district.persisted?
#     puts "District created: #{district.name}"
#   else
#     puts "District creation failed for #{district}."
#   end
# end

# CREATE CHAMBERS
# chambers= Chamber.create(
#   name: "কমপ্যাথ মেডিক্যাল সেন্টার",
#   category: "ডায়াগনস্টিক সেন্টার",
#   address: "কাজীর মোড়, নওগাঁ",
#   district_id: 1
# )
# CREATE CHAMBERS
# chambers= Chamber.create(
#   name: "পপুলার ডায়াগনস্টিক সেন্টার লিঃ,বগুড়া",
#   category: "ডায়াগনস্টিক সেন্টার",
#   address: "ঠনঠনিয়া, বগুড়া",
#   district_id: 3
# )

# chambers= Chamber.create(
#   name: "TMSS মেডিকেল কলেজ হাসপাতাল, বগুড়া",
#   category: "hospital",
#   address: "মহাস্থান রোড, বগুড়া",
#   district_id: 3
# )

# CREATE DOCTOR-SPECIALIZATIONS   // **We have to find more efficient way to add data in production
# doctor = Doctor.find_by(name: 'মোঃ রইস উদ্দিন')
# specialization = Specialization.find_by(name: 'হৃদরোগ')
# unless doctor.nil? || specialization.nil?
#   doctor_specialization = DoctorSpecialization.find_or_create_by(doctor: doctor, specialization: specialization)
#   if doctor_specialization.persisted?
#     puts "DoctorSpecialization created: #{doctor_specialization.doctor.name} - #{doctor_specialization.specialization.name}"
#   else
#     puts "DoctorSpecialization creation failed for #{doctor.name} - #{specialization.name}."
#   end
# end

## ADD DATA TO DOCTOR-SCHEDULES
# doctor = Doctor.find_by(name: 'মোঃ রইস উদ্দিন')
# chamber = Chamber.find_by(name: 'পপুলার ডায়াগনস্টিক সেন্টার লিঃ, রাজশাহী')
# unless doctor.nil? || chamber.nil?
#   doctor_schedule = DoctorSchedule.create(doctor: doctor, chamber: chamber, available_day: 'শনিবার থেকে বৃহস্পতিবার ', available_time: ' সন্ধ্যা ৬:০০  - রাত ১১:০০ ', contact: '09666787811')
#   if doctor_schedule.persisted?
#     puts "DoctorSchedule created: #{doctor_schedule.doctor.name} - #{doctor_schedule.chamber.name}"
#   else
#     puts "DoctorSchedule creation failed for #{doctor.name} - #{chamber.name}."
#   end
# end