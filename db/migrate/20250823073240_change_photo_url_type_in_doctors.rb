class ChangePhotoUrlTypeInDoctors < ActiveRecord::Migration[7.1]
  def change
    change_column :doctors, :photo_url, :text, null: true
  end
end
