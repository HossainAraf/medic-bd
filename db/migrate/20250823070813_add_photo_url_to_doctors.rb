class AddPhotoUrlToDoctors < ActiveRecord::Migration[7.1]
  def change
    add_column :doctors, :photo_url, :string, null: true
  end
end
