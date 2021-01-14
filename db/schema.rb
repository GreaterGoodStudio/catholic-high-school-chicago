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

ActiveRecord::Schema.define(version: 20210114154103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "calendar_event_translations", force: :cascade do |t|
    t.integer "calendar_event_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "description"
    t.index ["calendar_event_id"], name: "index_calendar_event_translations_on_calendar_event_id"
    t.index ["locale"], name: "index_calendar_event_translations_on_locale"
  end

  create_table "calendar_events", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.bigint "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_calendar_events_on_school_id"
  end

  create_table "faq_translations", force: :cascade do |t|
    t.integer "faq_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "question"
    t.text "answer"
    t.index ["faq_id"], name: "index_faq_translations_on_faq_id"
    t.index ["locale"], name: "index_faq_translations_on_locale"
  end

  create_table "faqs", force: :cascade do |t|
    t.string "question"
    t.string "answer"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "intro_translations", force: :cascade do |t|
    t.integer "intro_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "copy"
    t.index ["intro_id"], name: "index_intro_translations_on_intro_id"
    t.index ["locale"], name: "index_intro_translations_on_locale"
  end

  create_table "intros", force: :cascade do |t|
    t.string "page"
    t.text "copy"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scholarship_translations", force: :cascade do |t|
    t.integer "scholarship_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["locale"], name: "index_scholarship_translations_on_locale"
    t.index ["scholarship_id"], name: "index_scholarship_translations_on_scholarship_id"
  end

  create_table "scholarships", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "school_translations", force: :cascade do |t|
    t.integer "school_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "application"
    t.text "description"
    t.string "population_total"
    t.string "population_yearly"
    t.string "population_makeup"
    t.string "tuition_cost"
    t.string "tuition_merit"
    t.string "tuition_assistance"
    t.string "tuition_private"
    t.string "transportation_public"
    t.string "transportation_bus"
    t.string "transportation_l"
    t.string "transportation_metra"
    t.string "transportation_provided"
    t.string "programming_support"
    t.string "programming_academic"
    t.string "programming_ap"
    t.string "programming_extracurricular"
    t.string "programming_athletic"
    t.string "transportation_options"
    t.index ["locale"], name: "index_school_translations_on_locale"
    t.index ["school_id"], name: "index_school_translations_on_school_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "phone"
    t.string "website"
    t.string "application"
    t.text "description"
    t.string "population_total"
    t.string "population_yearly"
    t.string "population_makeup"
    t.string "tuition_cost"
    t.string "tuition_merit"
    t.string "tuition_assistance"
    t.string "tuition_private"
    t.string "tuition_link"
    t.string "transportation_public"
    t.string "transportation_bus"
    t.string "transportation_l"
    t.string "transportation_metra"
    t.string "transportation_provided"
    t.string "programming_support"
    t.string "programming_academic"
    t.string "programming_ap"
    t.string "programming_extracurricular"
    t.string "programming_athletic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "slug"
    t.string "shadowing_link"
    t.string "transportation_options"
    t.text "display_address"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name", default: "", null: false
    t.string "phone", default: "", null: false
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "calendar_events", "schools"
end
