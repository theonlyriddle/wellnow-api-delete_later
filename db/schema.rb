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

ActiveRecord::Schema.define(version: 20150108171305) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "availabilities", force: true do |t|
    t.integer  "doctor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "availability_general_id"
    t.integer  "slot_id"
  end

  add_index "availabilities", ["availability_general_id"], name: "index_availabilities_on_availability_general_id", using: :btree
  add_index "availabilities", ["doctor_id"], name: "index_availabilities_on_doctor_id", using: :btree
  add_index "availabilities", ["slot_id"], name: "index_availabilities_on_slot_id", using: :btree

  create_table "availability_generals", force: true do |t|
    t.integer  "day"
    t.time     "hour_from"
    t.time     "hour_to"
    t.integer  "doctor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "availability_generals", ["doctor_id"], name: "index_availability_generals_on_doctor_id", using: :btree

  create_table "capacities", force: true do |t|
    t.integer  "doctor_id"
    t.integer  "procedure_id"
    t.integer  "length"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "capacities", ["doctor_id"], name: "index_capacities_on_doctor_id", using: :btree
  add_index "capacities", ["procedure_id"], name: "index_capacities_on_procedure_id", using: :btree

  create_table "categories", force: true do |t|
    t.integer  "rank",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_doctors", id: false, force: true do |t|
    t.integer "doctor_id"
    t.integer "category_id"
  end

  add_index "categories_doctors", ["doctor_id", "category_id"], name: "index_categories_doctors_on_doctor_id_and_category_id", using: :btree

  create_table "category_translations", force: true do |t|
    t.integer  "category_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
  end

  add_index "category_translations", ["category_id"], name: "index_category_translations_on_category_id", using: :btree
  add_index "category_translations", ["locale"], name: "index_category_translations_on_locale", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "iso"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default",           default: false
    t.string   "default_time_zone"
  end

  create_table "doctors", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address"
    t.string   "address2"
    t.string   "zipcode"
    t.string   "locality"
    t.string   "email"
    t.integer  "country_id"
    t.string   "phone"
    t.string   "fax"
    t.string   "mobile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "background"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "time_zone"
  end

  add_index "doctors", ["country_id"], name: "index_doctors_on_country_id", using: :btree
  add_index "doctors", ["latitude", "longitude"], name: "index_doctors_on_latitude_and_longitude", using: :btree

  create_table "languages", force: true do |t|
    t.string   "name"
    t.string   "iso"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "procedure_translations", force: true do |t|
    t.integer  "procedure_id", null: false
    t.string   "locale",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "procedure_translations", ["locale"], name: "index_procedure_translations_on_locale", using: :btree
  add_index "procedure_translations", ["procedure_id"], name: "index_procedure_translations_on_procedure_id", using: :btree

  create_table "procedures", force: true do |t|
    t.integer  "default_length", default: 15
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "procedures", ["category_id"], name: "index_procedures_on_category_id", using: :btree

  create_table "searches", force: true do |t|
    t.integer  "category_id"
    t.float    "lon"
    t.float    "lat"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "radius"
  end

  add_index "searches", ["category_id"], name: "index_searches_on_category_id", using: :btree

  create_table "slots", force: true do |t|
    t.datetime "start"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slots", ["start"], name: "index_slots_on_start", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
