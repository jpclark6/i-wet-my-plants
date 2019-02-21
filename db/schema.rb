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

ActiveRecord::Schema.define(version: 2019_02_20_002653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gardens", force: :cascade do |t|
    t.string "name"
    t.integer "zip_code"
    t.bigint "user_id"
    t.string "twitter_handle"
    t.boolean "tweet", default: true
    t.string "secret_key"
    t.index ["user_id"], name: "index_gardens_on_user_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "name"
    t.string "species"
    t.integer "frequency"
    t.datetime "last_watered", default: "2019-02-21 00:17:25"
    t.bigint "garden_id"
    t.index ["garden_id"], name: "index_plants_on_garden_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "oauth_token"
    t.string "uid"
  end

  create_table "waterings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "plant_id"
    t.index ["plant_id"], name: "index_waterings_on_plant_id"
  end

  add_foreign_key "gardens", "users"
  add_foreign_key "plants", "gardens"
  add_foreign_key "waterings", "plants"
end
