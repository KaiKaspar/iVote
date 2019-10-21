class CreateProfilePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_pictures do |t|
      t.string :img_url
      t.timestamps
    end
  end
end
