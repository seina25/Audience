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

  create_table "cast_favorites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "member_id"
    t.integer "cast_id"
    t.index ["cast_id"], name: "index_cast_favorites_on_cast_id"
    t.index ["member_id"], name: "index_cast_favorites_on_member_id"
  end

  create_table "casts", force: :cascade do |t|
    t.string "name", null: false
    t.string "affiliation"
    t.string "occupation", null: false
    t.string "cast_image_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "affiliation", "occupation"], name: "index_casts_on_name_and_affiliation_and_occupation"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "title", null: false
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "member_id"
    t.index ["member_id"], name: "index_contacts_on_member_id"
    t.index ["title", "message"], name: "index_contacts_on_title_and_message"
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
    t.datetime "deleted_at"
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["kana_sei", "kana_mei"], name: "index_members_on_kana_sei_and_kana_mei"
    t.index ["last_name", "first_name"], name: "index_members_on_last_name_and_first_name"
    t.index ["nickname", "prefecture", "deleted_at"], name: "index_members_on_nickname_and_prefecture_and_deleted_at"
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
  end

  create_table "program_casts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "program_id"
    t.integer "cast_id"
    t.index ["cast_id"], name: "index_program_casts_on_cast_id"
    t.index ["program_id"], name: "index_program_casts_on_program_id"
  end

  create_table "program_favorites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "member_id"
    t.integer "program_id"
    t.index ["member_id"], name: "index_program_favorites_on_member_id"
    t.index ["program_id"], name: "index_program_favorites_on_program_id"
  end

  create_table "programs", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.integer "by_weekday", default: 0, null: false
    t.time "by_time", default: "2000-01-01 00:00:00", null: false
    t.string "program_image_id", null: false
    t.integer "status", null: false
    t.string "goods", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["by_weekday", "by_time"], name: "index_programs_on_by_weekday_and_by_time"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment", null: false
    t.float "score", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "member_id"
    t.integer "program_id"
    t.index ["member_id"], name: "index_reviews_on_member_id"
    t.index ["program_id"], name: "index_reviews_on_program_id"
  end

end
