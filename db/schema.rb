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

ActiveRecord::Schema.define(version: 20150918153439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.text     "title",          null: false
    t.text     "year"
    t.integer  "tracks_count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "cover_image"
    t.float    "duration"
    t.text     "description"
    t.string   "cover_designer"
  end

  create_table "albums_artists", id: false, force: :cascade do |t|
    t.integer "album_id",  null: false
    t.integer "artist_id", null: false
  end

  create_table "albums_producers", id: false, force: :cascade do |t|
    t.integer "album_id",    null: false
    t.integer "producer_id", null: false
  end

  create_table "artists", force: :cascade do |t|
    t.text     "name"
    t.text     "class_year"
    t.integer  "tracks_count"
    t.text     "bio"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "profile_picture"
  end

  create_table "artists_tracks", id: false, force: :cascade do |t|
    t.integer "artist_id", null: false
    t.integer "track_id",  null: false
  end

  create_table "playlists", force: :cascade do |t|
    t.text     "title"
    t.text     "author"
    t.integer  "user_id"
    t.boolean  "is_public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "duration"
  end

  add_index "playlists", ["user_id"], name: "index_playlists_on_user_id", using: :btree

  create_table "playlists_tracks", id: false, force: :cascade do |t|
    t.integer "playlist_id", null: false
    t.integer "track_id",    null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "cover_image"
    t.string   "author"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "producers", force: :cascade do |t|
    t.text     "name"
    t.text     "class_year"
    t.text     "bio"
    t.integer  "albums_count"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "profile_picture"
  end

  create_table "tracks", force: :cascade do |t|
    t.integer  "album_id"
    t.text     "title"
    t.integer  "track_number"
    t.float    "length_in_seconds"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "audio"
  end

  add_index "tracks", ["album_id"], name: "index_tracks_on_album_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.string   "role",                   default: "user"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "playlists", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "tracks", "albums"
end
