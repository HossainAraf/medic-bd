# # ADD SPECIALIZATIONS
# names = ['হৃদরোগ', 'মেডিসিন', 'শিশুরোগ', 'প্রসূতি ও স্ত্রীরোগ', 'মানসিক রোগ', 'নিউরোলজি', 'চর্ম ও যৌনরোগ ', 'ডায়াবেটিস', 'ইউরোলজি', 'বক্ষব্যাধি', 'হাড়-জোড় ও মেরুদন্ড', 'ক্যান্সার', 'জেনারেল সার্জারি', 'নাক-কান-গলা', 'চক্ষুরোগ', 'হরমোন', 'দন্তরোগ', 'রক্ত ও ব্লাড ক্যান্সার']

# names.each do |name|
#   specialization = Specialization.create(name: name)
#   if specialization.persisted?
#     puts "Specialization created: #{specialization.name}"
#   else
#     puts "Specialization creation failed for #{name}."
#   end
# end

# # ADD DOCTORS
doctors = Doctor.create(name: 'মোঃ মামুনুর রশীদ', specialty: 'চর্ম ও যৌন', qualification: 'এমবিবিএস, বিসিএস (স্বাস্থ্য), ডিডিভি (চর্ম ও যৌন), থাইল্যান্ড', experience: 'সহকারী পরিচালক,  জাতীয় হৃদরোগ ইন্সটিটিউট, ঢাকা', order: 700007)


# specialization = Specialization.create(name: 'হৃদরোগ')

# if specialization.persisted?
#   puts "Specialization created: #{specialization.name}"
# else
#   puts "Specialization creation failed."
# end