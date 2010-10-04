class CreateGeoexpatUsers < ActiveRecord::Migration
  def self.up
    create_table :geoexpat_users do |t|
      t.integer :geoexpat_id
      t.string :username

      t.timestamps
    end
  end

  def self.down
    drop_table :geoexpat_users
  end
end

