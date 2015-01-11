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

ActiveRecord::Schema.define(version: 20150111195810) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body"
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "availabilities", force: :cascade do |t|
    t.integer  "doctor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "availability_general_id"
    t.integer  "slot_id"
  end

  add_index "availabilities", ["availability_general_id"], name: "index_availabilities_on_availability_general_id", using: :btree
  add_index "availabilities", ["doctor_id"], name: "index_availabilities_on_doctor_id", using: :btree
  add_index "availabilities", ["slot_id"], name: "index_availabilities_on_slot_id", using: :btree

  create_table "availability_generals", force: :cascade do |t|
    t.integer  "day"
    t.time     "hour_from"
    t.time     "hour_to"
    t.integer  "doctor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "availability_generals", ["doctor_id"], name: "index_availability_generals_on_doctor_id", using: :btree

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "doctor_id"
    t.integer  "slot_id"
    t.integer  "capacity_id"
    t.text     "description"
    t.integer  "pain"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "bookings", ["capacity_id"], name: "index_bookings_on_capacity_id", using: :btree
  add_index "bookings", ["doctor_id"], name: "index_bookings_on_doctor_id", using: :btree
  add_index "bookings", ["slot_id"], name: "index_bookings_on_slot_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "capacities", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "procedure_id"
    t.integer  "length"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "capacities", ["doctor_id"], name: "index_capacities_on_doctor_id", using: :btree
  add_index "capacities", ["procedure_id"], name: "index_capacities_on_procedure_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.integer  "rank",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_doctors", id: false, force: :cascade do |t|
    t.integer "doctor_id"
    t.integer "category_id"
  end

  add_index "categories_doctors", ["doctor_id", "category_id"], name: "index_categories_doctors_on_doctor_id_and_category_id", using: :btree

  create_table "category_translations", force: :cascade do |t|
    t.integer  "category_id",             null: false
    t.string   "locale",      limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",       limit: 255
    t.text     "description"
  end

  add_index "category_translations", ["category_id"], name: "index_category_translations_on_category_id", using: :btree
  add_index "category_translations", ["locale"], name: "index_category_translations_on_locale", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "email",      limit: 255
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "iso",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default",                       default: false
    t.string   "default_time_zone", limit: 255
  end

  create_table "doctors", force: :cascade do |t|
    t.string   "firstname",  limit: 255
    t.string   "lastname",   limit: 255
    t.string   "address",    limit: 255
    t.string   "address2",   limit: 255
    t.string   "zipcode",    limit: 255
    t.string   "locality",   limit: 255
    t.string   "email",      limit: 255
    t.integer  "country_id"
    t.string   "phone",      limit: 255
    t.string   "fax",        limit: 255
    t.string   "mobile",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar",     limit: 255
    t.string   "background", limit: 255
    t.float    "latitude"
    t.float    "longitude"
    t.string   "time_zone",  limit: 255
  end

  add_index "doctors", ["country_id"], name: "index_doctors_on_country_id", using: :btree
  add_index "doctors", ["latitude", "longitude"], name: "index_doctors_on_latitude_and_longitude", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "place"
    t.boolean  "is_all_day",            default: false
    t.datetime "datetime_from"
    t.datetime "datetime_to"
    t.boolean  "is_recurring",          default: false
    t.string   "schedule"
    t.boolean  "has_end_of_recurrence", default: false
    t.datetime "end_of_recurrence"
    t.integer  "parent_id"
    t.integer  "doctor_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "events", ["doctor_id"], name: "index_events_on_doctor_id", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "iso",        limit: 255
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "procedure_translations", force: :cascade do |t|
    t.integer  "procedure_id",             null: false
    t.string   "locale",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",         limit: 255
  end

  add_index "procedure_translations", ["locale"], name: "index_procedure_translations_on_locale", using: :btree
  add_index "procedure_translations", ["procedure_id"], name: "index_procedure_translations_on_procedure_id", using: :btree

  create_table "procedures", force: :cascade do |t|
    t.integer  "default_length", default: 15
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "procedures", ["category_id"], name: "index_procedures_on_category_id", using: :btree

  create_table "searches", force: :cascade do |t|
    t.integer  "category_id"
    t.float    "lon"
    t.float    "lat"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "radius"
  end

  add_index "searches", ["category_id"], name: "index_searches_on_category_id", using: :btree

  create_table "slots", force: :cascade do |t|
    t.datetime "start"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slots", ["start"], name: "index_slots_on_start", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address"
    t.string   "address2"
    t.string   "zipcode"
    t.string   "locality"
    t.integer  "country_id"
    t.string   "phone"
    t.date     "birthdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["country_id"], name: "index_users_on_country_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255, null: false
    t.integer  "item_id",                null: false
    t.string   "event",      limit: 255, null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "bookings", "capacities"
  add_foreign_key "bookings", "doctors"
  add_foreign_key "bookings", "slots"
  add_foreign_key "bookings", "users"
end
