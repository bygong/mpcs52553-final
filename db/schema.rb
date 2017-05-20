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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "date_segments", force: :cascade do |t|
    t.integer "restaurant_id"
    t.text    "date"
    t.index ["restaurant_id"], name: "index_date_segments_on_restaurant_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.text    "size"
    t.text    "review"
    t.integer "user_id"
    t.integer "time_segment_id"
    t.index ["time_segment_id"], name: "index_reservations_on_time_segment_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.text    "name"
    t.integer "table_number"
  end

  create_table "time_segments", force: :cascade do |t|
    t.integer "restaurant_id"
    t.integer "time"
    t.integer "date_segment_id"
    t.integer "table_left"
    t.index ["date_segment_id"], name: "index_time_segments_on_date_segment_id"
    t.index ["restaurant_id"], name: "index_time_segments_on_restaurant_id"
  end

  create_table "users", force: :cascade do |t|
    t.text    "name"
    t.integer "points"
    t.text    "email_address"
    t.text    "password_digest"
    t.boolean "admin",           default: false
  end

end
