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

ActiveRecord::Schema.define(:version => 20130601103610) do

  create_table "addresses", :force => true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.string   "address_type_id"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "contact_type_id"
    t.string   "image"
  end

  add_index "companies", ["name"], :name => "index_companies_on_name", :unique => true

  create_table "currencies", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "currencies", ["abbreviation"], :name => "index_currencies_on_abbreviation", :unique => true
  add_index "currencies", ["name"], :name => "index_currencies_on_name", :unique => true

  create_table "deals", :force => true do |t|
    t.integer  "dealable_id"
    t.string   "dealable_type"
    t.string   "name"
    t.text     "description"
    t.integer  "currency_id"
    t.decimal  "budget"
    t.integer  "budget_type_id"
    t.date     "closing_date"
    t.integer  "stage_id"
    t.integer  "success_probability"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "user_id"
  end

  create_table "emails", :force => true do |t|
    t.string   "email"
    t.string   "email_type_id"
    t.integer  "emailable_id"
    t.string   "emailable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.boolean  "opened",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "histories", :force => true do |t|
    t.integer  "historable_id"
    t.string   "historable_type"
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "deal_id"
    t.integer  "history_type_id"
    t.date     "date"
    t.text     "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "import_cells", :force => true do |t|
    t.integer  "import_row_id"
    t.integer  "number"
    t.text     "header"
    t.text     "data"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "import_rows", :force => true do |t|
    t.integer  "import_table_id"
    t.integer  "number"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "import_tables", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "participations", :force => true do |t|
    t.integer  "participatiable_id"
    t.string   "participatiable_type"
    t.integer  "deal_id"
    t.integer  "event_id"
    t.string   "type"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "company_id"
    t.string   "job"
    t.text     "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "contact_type_id"
    t.string   "image"
    t.string   "full_name"
  end

  create_table "phones", :force => true do |t|
    t.string   "phone"
    t.string   "phone_type_id"
    t.integer  "phoneable_id"
    t.string   "phoneable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "recent_actions", :force => true do |t|
    t.integer  "actionable_id"
    t.string   "actionable_type"
    t.integer  "action_type_id"
    t.integer  "user_id"
    t.string   "comment"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "recent_items", :force => true do |t|
    t.integer  "itemable_id"
    t.string   "itemable_type"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "comment"
  end

  create_table "stages", :force => true do |t|
    t.string   "name"
    t.integer  "success_probability"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "stages", ["name"], :name => "index_stages_on_name", :unique => true

  create_table "tasks", :force => true do |t|
    t.integer  "taskable_id"
    t.string   "taskable_type"
    t.integer  "event_id"
    t.integer  "deal_id"
    t.string   "name"
    t.integer  "task_type_id"
    t.string   "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.date     "deadline_date"
    t.integer  "user_id"
  end

  create_table "types", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_contacts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "user_contact_type_id"
    t.string   "user_contact"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
    t.string   "name"
    t.string   "image"
    t.string   "gender"
    t.date     "birthday"
    t.text     "comment"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
