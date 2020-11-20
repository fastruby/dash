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

ActiveRecord::Schema.define(version: 2020_10_12_013526) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "issues", force: :cascade do |t|
    t.string "title"
    t.integer "issue_number"
    t.string "issue_link"
    t.string "repository_link"
    t.string "state"
    t.string "repository_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "issues_assignees", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "issue_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["issue_id"], name: "index_issues_assignees_on_issue_id"
    t.index ["user_id"], name: "index_issues_assignees_on_user_id"
  end

  create_table "pivotal_projects", force: :cascade do |t|
    t.integer "pivotal_id"
    t.integer "version"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pivotal_id"], name: "index_pivotal_projects_on_pivotal_id", unique: true
  end

  create_table "pivotal_stories", force: :cascade do |t|
    t.string "name"
    t.integer "story_number"
    t.string "story_link"
    t.string "project_link"
    t.string "project_name"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["story_number"], name: "index_pivotal_stories_on_story_number", unique: true
  end

  create_table "pivotal_stories_owners", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "pivotal_story_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pivotal_story_id"], name: "index_pivotal_stories_owners_on_pivotal_story_id"
    t.index ["user_id"], name: "index_pivotal_stories_owners_on_user_id"
  end

  create_table "pull_requests", force: :cascade do |t|
    t.string "title"
    t.integer "pull_request_number"
    t.string "pull_request_link"
    t.string "repository_link"
    t.string "state"
    t.string "repository_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "author"
  end

  create_table "pull_requests_assignees", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "pull_request_id", null: false
    t.index ["pull_request_id"], name: "index_pull_requests_assignees_on_pull_request_id"
    t.index ["user_id"], name: "index_pull_requests_assignees_on_user_id"
  end

  create_table "pull_requests_reviewers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "pull_request_id"
    t.index ["pull_request_id"], name: "index_pull_requests_reviewers_on_pull_request_id"
    t.index ["user_id"], name: "index_pull_requests_reviewers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "pivotal_token_ciphertext"
    t.string "pivotal_id"
  end

  add_foreign_key "issues_assignees", "issues", on_delete: :cascade
  add_foreign_key "issues_assignees", "users"
  add_foreign_key "pivotal_stories_owners", "pivotal_stories", on_delete: :cascade
  add_foreign_key "pivotal_stories_owners", "users"
  add_foreign_key "pull_requests_assignees", "pull_requests", on_delete: :cascade
  add_foreign_key "pull_requests_assignees", "users"
  add_foreign_key "pull_requests_reviewers", "pull_requests", on_delete: :cascade
end
