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
District.create([
  { name: 'Naogaon', created_at: Time.now, updated_at: Time.now }, 
   { name: 'Rajshahi', created_at: Time.now, updated_at: Time.now },
])

