class AddSpecialNotesAndDescriptionToDoctors < ActiveRecord::Migration[7.1]
  def change
    add_column :doctors, :special_notes, :text, null: true
    add_column :doctors, :description, :text, null: true
  end
end
