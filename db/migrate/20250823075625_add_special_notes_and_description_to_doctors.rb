class AddSpecialNotesAndDescriptionToDoctors < ActiveRecord::Migration[7.1]
  def change
    add_column :doctors, :special_notes, :text
    add_column :doctors, :description, :text
  end
end
