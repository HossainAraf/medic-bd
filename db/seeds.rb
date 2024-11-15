require_relative '../app/models/specialization'

specialization = Specialization.new(
  name: 'হৃদরোগ'
)
if specialization.save
  puts "Specialization created: #{specialization.name}"
else
  puts "Specialization creation failed."
end
