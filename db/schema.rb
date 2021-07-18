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

ActiveRecord::Schema.define(version: 2021_07_09_034215) do

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "contacts", force: :cascade do |t|
    t.string "title", null: false
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "member_id"
    t.index ["member_id"], name: "index_contacts_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "last_name"
    t.string "first_name"
    t.string "kana_sei"
    t.string "kana_mei"
    t.string "nickname"
    t.integer "gender", default: 0, null: false
    t.string "profile_image_id"
    t.string "prefecture"
    t.string "line_id"
    t.boolean "is_valid", default: true, null: false
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
  end

  create_table "program_favorites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "member_id"
    t.bigint "program_id"
    t.index ["member_id"], name: "index_program_favorites_on_member_id"
    t.index ["program_id"], name: "index_program_favorites_on_program_id"
  end

  create_table "programs", force: :cascade do |t|
    t.string "title", null: false
    t.string "second_title", null: false
    t.string "category", null: false
    t.string "cast"
    t.string "channel", null: false
    t.datetime "start_datetime", null: false
    t.datetime "end_datetime", null: false
    t.integer "by_weekday", default: 0, null: false
    t.string "program_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel", "start_datetime"], name: "index_programs_on_channel_and_start_datetime", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment", null: false
    t.float "score", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "member_id"
    t.bigint "program_id"
    t.index ["member_id"], name: "index_reviews_on_member_id"
    t.index ["program_id"], name: "index_reviews_on_program_id"
  end

end
