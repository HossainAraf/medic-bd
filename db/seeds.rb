
# ALWAYS KEEP THIS FILE empty to avoid accidental seed . There is seed.md file for reference# db/seeds.rb
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
    else
      puts "❌ Failed to create district: #{district.name}. Errors: #{district.errors.full_messages.join(', ')}"
    end  
    end

    puts "Seeding completed. Total districts created: #{created_count}"
    puts "Total districts in database: #{District.count}"