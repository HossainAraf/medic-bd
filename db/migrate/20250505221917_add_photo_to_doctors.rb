class AddPhotoToDoctors < ActiveRecord::Migration[7.1]
  def change
    add_column :doctors, :photo, :string
  end
end
