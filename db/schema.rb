# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100812173527) do

  create_table "albums", :force => true do |t|
    t.integer  "s_album_id"
    t.integer  "subcategory_id"
    t.integer  "category_id"
    t.string   "title"
    t.string   "description"
    t.string   "subcategory"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.integer  "s_category_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.integer  "width"
    t.integer  "height"
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_name"
    t.integer  "album_id"
    t.integer  "s_image_id"
    t.string   "keywords"
    t.integer  "size"
    t.string   "TinyURL"
    t.string   "ThumbURL"
    t.string   "SmallURL"
    t.string   "MediumURL"
    t.string   "LargeURL"
    t.string   "XLargeURL"
    t.string   "X2LargeURL"
    t.string   "X3LargeURL"
    t.string   "OriginalURL"
    t.string   "Video320URL"
    t.string   "Video640URL"
    t.string   "Video960URL"
    t.string   "Video12800URL"
  end

  create_table "subcategories", :force => true do |t|
    t.integer  "s_subcategory_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
