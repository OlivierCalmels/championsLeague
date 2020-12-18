# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_18_004056) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.bigint "tournament_id", null: false
    t.bigint "first_team_id", null: false
    t.bigint "second_team_id", null: false
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["first_team_id"], name: "index_groups_on_first_team_id"
    t.index ["second_team_id"], name: "index_groups_on_second_team_id"
    t.index ["tournament_id"], name: "index_groups_on_tournament_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "groups", "teams", column: "first_team_id"
  add_foreign_key "groups", "teams", column: "second_team_id"
  add_foreign_key "groups", "tournaments"
end
