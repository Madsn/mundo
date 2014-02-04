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

ActiveRecord::Schema.define(version: 20140204191240) do

  create_table "charts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",   limit: 50
    t.string   "email",      limit: 50
    t.string   "auth_token", limit: 50
    t.string   "password",   limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "workouts", force: true do |t|
    t.string   "username"
    t.string   "sport",         limit: 50
    t.integer  "endo_sport_id"
    t.float    "distance"
    t.datetime "start_time"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workouts", ["endo_sport_id"], name: "index_workouts_on_endo_sport_id"
  add_index "workouts", ["username"], name: "index_workouts_on_username"

end
