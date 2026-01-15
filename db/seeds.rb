District.find_or_create_by!(name: "Naogaon") do |d|
  d.created_at = Time.now
  d.updated_at = Time.now
end


puts "=== RUNNING SEEDS FROM medic-bd-api ==="

district = District.third
raise "No districts found" unless district

Chamber.find_or_create_by!(
  name: "Holipath",
  district_id: district.id
) do |c|
  c.address  = "Rubir mor, Naogaon"
  c.category = "Clinic"
end

puts "=== SEEDS COMPLETED ==="
