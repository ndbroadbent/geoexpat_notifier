class CreateFilters < ActiveRecord::Migration
  def self.up
    create_table :filters do |t|
      t.decimal :from_price, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.decimal :to_price, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.string :query
      t.text :contains_all_words
      t.text :contains_any_words
      t.text :contains_no_words
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :filters
  end
end

