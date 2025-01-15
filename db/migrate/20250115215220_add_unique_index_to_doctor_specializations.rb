class AddUniqueIndexToDoctorSpecializations < ActiveRecord::Migration[7.1]
  def change
    add_index :doctor_specializations, [:doctor_id, :specialization_id], unique: true, name: 'unique_doctor_specializations'
  end
end
