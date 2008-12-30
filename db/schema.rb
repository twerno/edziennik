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

ActiveRecord::Schema.define(:version => 20081230130737) do

  create_table "archives", :force => true do |t|
    t.string   "class_name"
    t.string   "class_id"
    t.boolean  "class_destroyed"
    t.integer  "edited_by"
    t.text     "editors_stamp"
    t.text     "body"
    t.datetime "body_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "archives", ["class_id"], :name => "index_archives_on_class_id"

  create_table "czlonkowie", :force => true do |t|
    t.integer  "uczen_id"
    t.integer  "grupa_id"
    t.boolean  "destroyed",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "godziny", :force => true do |t|
    t.string   "nazwa"
    t.time     "begin"
    t.time     "end"
    t.boolean  "destroyed",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grupy", :force => true do |t|
    t.string   "nazwa"
    t.boolean  "klasa"
    t.integer  "grupa_id"
    t.integer  "nauczyciel_id"
    t.integer  "aktualny_semestr"
    t.integer  "pierwszy_semestr"
    t.integer  "ostatni_semestr"
    t.boolean  "destroyed",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lekcje", :force => true do |t|
    t.integer  "godzina_id"
    t.integer  "lista_id"
    t.integer  "plan_id"
    t.date     "data"
    t.boolean  "destroyed",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listy", :force => true do |t|
    t.integer  "grupa_id"
    t.integer  "nauczyciel_id"
    t.integer  "semestr_id"
    t.integer  "przedmiot_id"
    t.boolean  "destroyed",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nauczyciele", :force => true do |t|
    t.string   "imie"
    t.string   "nazwisko"
    t.integer  "user_id"
    t.integer  "pnjt"
    t.boolean  "destroyed",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "obecnosci", :force => true do |t|
    t.integer  "wartosc"
    t.integer  "uczne_id"
    t.integer  "lista_id"
    t.integer  "lekcja_id"
    t.boolean  "destroyed",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oceny", :force => true do |t|
    t.integer  "wartosc_oceny"
    t.integer  "typ_oceny"
    t.integer  "uczen_id"
    t.integer  "lista_id"
    t.integer  "lekcja_id"
    t.integer  "nauczyciel_id"
    t.boolean  "destroyed",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "passwords", :force => true do |t|
    t.integer  "user_id"
    t.string   "reset_code"
    t.datetime "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plany", :force => true do |t|
    t.string   "nazwa"
    t.integer  "semestr_id"
    t.boolean  "active"
    t.boolean  "destroyed",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pnjts", :force => true do |t|
    t.integer  "nauczyciel_id"
    t.integer  "przedmiot_id"
    t.boolean  "destroyed",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "przedmioty", :force => true do |t|
    t.string   "nazwa"
    t.integer  "pnjt_id"
    t.boolean  "destroyed",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rodzice", :force => true do |t|
    t.string   "imie_ojca"
    t.string   "imie_matki"
    t.string   "nazwistko"
    t.string   "nazwisko_panienskie"
    t.integer  "user_id"
    t.boolean  "destroyed",           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "semestry", :force => true do |t|
    t.string   "nazwa"
    t.date     "begin"
    t.date     "end"
    t.boolean  "aktualny"
    t.boolean  "destroyed",  :default => false
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

  create_table "uczniowie", :force => true do |t|
    t.string   "imie"
    t.string   "nazwisko"
    t.string   "pesel"
    t.string   "nr_legitymacji"
    t.integer  "rodzic_id"
    t.boolean  "chlopiec"
    t.integer  "user_id"
    t.boolean  "destroyed",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "identity_url"
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token",            :limit => 40
    t.string   "activation_code",           :limit => 40
    t.string   "state",                                    :default => "passive", :null => false
    t.datetime "remember_token_expires_at"
    t.datetime "activated_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "destroyed",                                :default => false
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
