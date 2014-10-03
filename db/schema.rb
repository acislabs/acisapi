# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141002185917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ignored_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "ignorable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ignored_users", ["ignorable_id"], name: "index_ignored_users_on_ignorable_id", using: :btree
  add_index "ignored_users", ["user_id"], name: "index_ignored_users_on_user_id", using: :btree

  create_table "profiles", force: true do |t|
    t.string   "profile_type",        default: "Personal", null: false
    t.string   "name"
    t.string   "email"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "website"
    t.string   "company"
    t.string   "job_title"
    t.boolean  "default",             default: false,      null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "mobile_number"
    t.string   "access_token"
    t.string   "operating_system", default: "Android", null: false
    t.string   "device_token"
    t.boolean  "active",           default: true,      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["mobile_number"], name: "index_users_on_mobile_number", using: :btree

  create_table "verification_codes", force: true do |t|
    t.string   "mobile_number"
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
