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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111013215821) do

  create_table "adoption_contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "uuid"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.integer  "animal_id"
    t.datetime "adopted_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animal_colors", :force => true do |t|
    t.string   "color"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  create_table "animal_weights", :force => true do |t|
    t.integer  "animal_id"
    t.string   "uuid"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animals", :force => true do |t|
    t.string   "name"
    t.string   "uuid"
    t.string   "previous_name"
    t.integer  "species_id"
    t.string   "sex"
    t.string   "spay_neuter"
    t.string   "color"
    t.integer  "age"
    t.string   "biter"
    t.text     "special_needs"
    t.text     "diet"
    t.datetime "date_of_intake"
    t.datetime "date_of_well_check"
    t.integer  "shelter_id"
    t.datetime "deceased"
    t.text     "deceased_reason"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.datetime "adopted_date"
    t.integer  "animal_color_id"
    t.string   "image"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "public",             :default => 0
  end

  create_table "facebook_accounts", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "active",              :default => false
    t.text     "stream_url"
    t.text     "access_token"
    t.text     "oauth_authorize_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "email"
    t.string   "website"
  end

  create_table "organizations_users", :id => false, :force => true do |t|
    t.integer "organization_id"
    t.integer "user_id"
  end

  create_table "permissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month"
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "relinquishment_contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "uuid"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.integer  "animal_id"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shelters", :force => true do |t|
    t.string   "name"
    t.string   "uuid"
    t.string   "contact_first"
    t.string   "contact_last"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  create_table "species", :force => true do |t|
    t.string   "name"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  create_table "twitter_accounts", :force => true do |t|
    t.integer "user_id"
    t.boolean "active",               :default => false
    t.text    "stream_url"
    t.string  "oauth_token"
    t.string  "oauth_token_secret"
    t.string  "oauth_token_verifier"
    t.text    "oauth_authorize_url"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "vet_contacts", :force => true do |t|
    t.string   "clinic_name"
    t.string   "uuid"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.string   "hours"
    t.string   "emergency"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "volunteer_contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "uuid"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.datetime "application_date"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
