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

ActiveRecord::Schema.define(:version => 20130520171747) do

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "gag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "gaglikes", :force => true do |t|
    t.integer  "liker_id"
    t.integer  "liked_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "vote_sign"
  end

  add_index "gaglikes", ["liked_id"], :name => "index_gaglikes_on_liked_id"
  add_index "gaglikes", ["liker_id", "liked_id"], :name => "index_gaglikes_on_liker_id_and_liked_id", :unique => true
  add_index "gaglikes", ["liker_id"], :name => "index_gaglikes_on_liker_id"

  create_table "gagreports", :force => true do |t|
    t.integer  "reported_id"
    t.integer  "reporter_id"
    t.integer  "report_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "gagreports", ["reported_id"], :name => "index_gagreports_on_reported_id"
  add_index "gagreports", ["reporter_id", "reported_id"], :name => "index_gagreports_on_reporter_id_and_reported_id", :unique => true
  add_index "gagreports", ["reporter_id"], :name => "index_gagreports_on_reporter_id"

  create_table "gags", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "votes"
    t.integer  "votes_up"
    t.float    "ratio"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "imagelink"
    t.string   "videolink"
  end

  add_index "gags", ["user_id", "created_at"], :name => "index_gags_on_user_id_and_created_at"

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "admin",               :default => false
    t.integer  "theme"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
