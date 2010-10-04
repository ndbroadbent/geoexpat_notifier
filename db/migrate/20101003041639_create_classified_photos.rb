class CreateClassifiedPhotos < ActiveRecord::Migration
  def self.up
    create_table :classified_photos do |t|
      t.integer :classified_id
      t.integer :folder_id
      t.string :filename

      t.timestamps
    end
  end

  def self.down
    drop_table :classified_photos
  end
end

