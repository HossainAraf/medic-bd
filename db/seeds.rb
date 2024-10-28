# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Add data to feedbacks table where model name is FeedbackForm
# FeedbackForm.create([
#   { feedback: 'i am the body of the feedback', name: 'John Doe', email: 'john@xyz.com', phone: '1234567890', subject: 'Feedback', message: 'This is a feedback message', created_at: Time.now, updated_at: Time.now }
# ])

# ADD DATA TO FEEDBACK_FORMS TABLE
# feedback = FeedbackForm.new(
#   feedback: 'i am the body of the feedback',
#   name: 'John Doe',
#   email: 'john@xyz.com',
#   phone: '1234567890',
#   created_at: Time.now,
#   updated_at: Time.now
# )

# if feedback.save
#   puts 'Feedback saved successfully!'
# else
#   puts 'Failed to save feedback: ' + feedback.errors.full_messages.join(', ')
# end

# Add data to districts table where model name is District
# Chember.create([
#   { name: 'শুভ ক্লিনিক', address; ' চকএনায়েত, দয়ালের মোড়, নওগাঁ', type: 'clinic', district_id: '1', contact: '01728-174202', created_at: Time.now, updated_at: Time.now }, 
#   { name: 'ল্যাবএইড লিমিটেড', address; ' কাজীর মোড়, নওগাঁ', type: 'Diagnostic', district_id: '1', contact: '01766-661313', created_at: Time.now, updated_at: Time.now }, 
# ])

# chember = Chember.new(
#   name: 'শুভ ক্লিনিক',
#   address: 'চকএনায়েত, দয়ালের মোড়, নওগাঁ',
#   chembers_type: 'clinic',
#   district_id: '1',
#   contact: '01728-174202',
#   created_at: Time.now,
#   updated_at: Time.now
# )
# chember.save

# db/seeds.rb

# Create Chember with district_id 1 (Naogaon)
# chember = Chember.new(
#   name: 'কমপ্যাথ মেডিক্যাল সেন্টার',
#   address: 'কাজীর মোড়, নওগাঁ',
#   chembers_type: 'Diagnostic',
#   district_id: 1,
#   contact: '01712-959699'
# )

# if chember.save
#   puts "Chember saved successfully!"
# else
#   puts "Failed to save Chember:"
#   puts chember.errors.full_messages
# end

# Create DoctroSchedule with district_id 1 (Naogaon)
doctor_schedule = DoctorSchedule.new(
  doctor_id: 2,
  district_id: 1,
  chember_id: 2,
  available_day: 'শুক্রবার',
  available_time: 'সকাল ১১:০০ - বিকাল ৪:০০',
  created_at: Time.now,
  updated_at: Time.now
)

if doctor_schedule.save
  puts "DoctorSchedule saved successfully!"
else
  puts "Failed to save DoctorSchedule:"
  puts doctor_schedule.errors.full_messages
end
  


