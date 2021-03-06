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

ActiveRecord::Schema.define(version: 2019_06_23_210620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "influencers", force: :cascade do |t|
    t.string "name"
    t.string "instagram"
    t.string "twitter"
    t.date "birth_date"
    t.date "signup_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workouts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "duration_mins"
    t.boolean "is_private", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "influencer_id"
    t.index ["influencer_id"], name: "index_workouts_on_influencer_id"
  end

  add_foreign_key "workouts", "influencers"
end
