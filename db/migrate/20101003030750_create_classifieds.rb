class CreateClassifieds < ActiveRecord::Migration
  def self.up
    create_table :classifieds do |t|
      t.integer :geoexpat_id
      t.integer :category_id
      t.string :title
      t.integer :geoexpat_user_id
      t.decimal :price, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.text :description
      t.datetime :list_date
      t.integer :views
      t.string :condition
      t.string :location

      t.timestamps
    end
  end

  def self.down
    drop_table :classifieds
  end
end

