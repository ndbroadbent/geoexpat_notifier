# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101003220759) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classified_photos", :force => true do |t|
    t.integer  "classified_id"
    t.integer  "folder_id"
    t.string   "filename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classifieds", :force => true do |t|
    t.integer  "geoexpat_id"
    t.integer  "category_id"
    t.string   "title"
    t.integer  "geoexpat_user_id"
    t.decimal  "price",            :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.text     "description"
    t.datetime "list_date"
    t.integer  "views"
    t.string   "condition"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "filters", :force => true do |t|
    t.decimal  "from_price",         :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "to_price",           :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.string   "query"
    t.text     "contains_all_words"
    t.text     "contains_any_words"
    t.text     "contains_no_words"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "geoexpat_users", :force => true do |t|
    t.integer  "geoexpat_id"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
