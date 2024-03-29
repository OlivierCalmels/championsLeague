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

ActiveRecord::Schema.define(version: 2021_01_12_201107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "draws", force: :cascade do |t|
    t.bigint "tournament_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tournament_id"], name: "index_draws_on_tournament_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "tournament_id", null: false
    t.bigint "team1_id"
    t.bigint "team2_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team1_id"], name: "index_groups_on_team1_id"
    t.index ["team2_id"], name: "index_groups_on_team2_id"
    t.index ["tournament_id"], name: "index_groups_on_tournament_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "name"
    t.bigint "draw_id", null: false
    t.bigint "team1_id"
    t.bigint "team2_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["draw_id"], name: "index_matches_on_draw_id"
    t.index ["team1_id"], name: "index_matches_on_team1_id"
    t.index ["team2_id"], name: "index_matches_on_team2_id"
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

  add_foreign_key "draws", "tournaments"
  add_foreign_key "groups", "teams", column: "team1_id"
  add_foreign_key "groups", "teams", column: "team2_id"
  add_foreign_key "groups", "tournaments"
  add_foreign_key "matches", "draws"
  add_foreign_key "matches", "teams", column: "team1_id"
  add_foreign_key "matches", "teams", column: "team2_id"
end
