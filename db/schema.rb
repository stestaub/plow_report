# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_16_111236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.bigint "company_id"
    t.string "name", default: "", null: false
    t.boolean "has_value", default: true, null: false
    t.string "value_label"
    t.index ["company_id", "name"], name: "index_activities_on_company_id_and_name", unique: true
    t.index ["company_id"], name: "index_activities_on_company_id"
    t.index ["name"], name: "index_activities_on_name"
  end

  create_table "activity_executions", force: :cascade do |t|
    t.bigint "activity_id"
    t.bigint "drive_id"
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activity_executions_on_activity_id"
    t.index ["drive_id"], name: "index_activity_executions_on_drive_id"
  end

  create_table "administrators", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.json "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.json "options", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_email", null: false
    t.string "address", default: "", null: false
    t.string "zip_code", default: "", null: false
    t.string "city", default: "", null: false
    t.string "slug"
    t.string "nr", default: "", null: false
    t.index ["name"], name: "index_companies_on_name", unique: true
    t.index ["slug"], name: "index_companies_on_slug", unique: true
  end

  create_table "company_members", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "company_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_members_on_company_id"
    t.index ["user_id", "company_id"], name: "index_company_members_on_user_id_and_company_id", unique: true
    t.index ["user_id"], name: "index_company_members_on_user_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "street", default: "", null: false
    t.string "nr", default: "", null: false
    t.string "zip", default: "", null: false
    t.string "city", default: "", null: false
    t.string "first_name", default: "", null: false
    t.index ["company_id"], name: "index_customers_on_company_id"
  end

  create_table "driver_applications", force: :cascade do |t|
    t.bigint "user_id"
    t.string "recipient", null: false
    t.string "token", null: false
    t.bigint "accepted_by_id"
    t.bigint "accepted_to_id"
    t.datetime "accepted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accepted_by_id"], name: "index_driver_applications_on_accepted_by_id"
    t.index ["accepted_to_id"], name: "index_driver_applications_on_accepted_to_id"
    t.index ["token"], name: "index_driver_applications_on_token"
    t.index ["user_id"], name: "index_driver_applications_on_user_id"
  end

  create_table "driver_logins", force: :cascade do |t|
    t.bigint "driver_id"
    t.bigint "user_id"
    t.index ["driver_id", "user_id"], name: "index_driver_logins_on_driver_id_and_user_id", unique: true
    t.index ["driver_id"], name: "index_driver_logins_on_driver_id"
    t.index ["driver_id"], name: "uniq_index_driver_logins_on_driver_id", unique: true
    t.index ["user_id"], name: "index_driver_logins_on_user_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_drivers_on_discarded_at"
  end

  create_table "drives", force: :cascade do |t|
    t.datetime "start", null: false
    t.datetime "end", null: false
    t.float "distance_km", default: 0.0, null: false
    t.boolean "salt_refilled", default: false, null: false
    t.float "salt_amount_tonns", default: 0.0, null: false
    t.boolean "salted", default: false, null: false
    t.boolean "plowed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "driver_id", null: false
    t.bigint "customer_id"
    t.bigint "site_id"
    t.datetime "discarded_at"
    t.uuid "tour_id"
    t.bigint "vehicle_id"
    t.index ["customer_id"], name: "index_drives_on_customer_id"
    t.index ["discarded_at"], name: "index_drives_on_discarded_at"
    t.index ["site_id"], name: "index_drives_on_site_id"
    t.index ["start", "end"], name: "index_drives_on_start_and_end"
    t.index ["tour_id"], name: "index_drives_on_tour_id"
    t.index ["vehicle_id"], name: "index_drives_on_vehicle_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default_app", default: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "policy_terms", force: :cascade do |t|
    t.string "key"
    t.boolean "required"
    t.text "short_description"
    t.text "description"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "version_date", default: "2021-02-16 12:20:24", null: false
  end

  create_table "pricing_flat_rates", force: :cascade do |t|
    t.string "flat_ratable_type"
    t.bigint "flat_ratable_id"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", null: false
    t.date "valid_from", null: false
    t.string "rate_type", default: "custom", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: false
    t.index ["flat_ratable_id", "flat_ratable_type", "rate_type"], name: "index_flat_rates_on_rable_id_ratable_type_rate_type"
    t.index ["flat_ratable_type", "flat_ratable_id"], name: "index_flat_rates_on_rable_id_ratable_type"
  end

  create_table "pricing_hourly_rates", force: :cascade do |t|
    t.string "hourly_ratable_type"
    t.bigint "hourly_ratable_id"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", null: false
    t.date "valid_from", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hourly_ratable_type", "hourly_ratable_id"], name: "index_hourly_rates_on_hourly_priceable_id"
  end

  create_table "recordings", force: :cascade do |t|
    t.datetime "start_time", null: false
    t.bigint "driver_id"
    t.index ["driver_id"], name: "index_recordings_on_driver_id", unique: true
  end

  create_table "site_activity_flat_rates", force: :cascade do |t|
    t.bigint "site_id"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_site_activity_flat_rates_on_activity_id"
    t.index ["site_id"], name: "index_site_activity_flat_rates_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "street", default: "", null: false
    t.string "nr", default: "", null: false
    t.string "zip", default: "", null: false
    t.string "city", default: "", null: false
    t.bigint "customer_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display_name", default: "", null: false
    t.string "first_name", default: "", null: false
    t.json "area_json", default: {}, null: false
    t.index ["customer_id"], name: "index_sites_on_customer_id"
    t.index ["display_name"], name: "index_sites_on_display_name"
  end

  create_table "standby_dates", force: :cascade do |t|
    t.date "day", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "driver_id", null: false
    t.index ["day"], name: "index_standby_dates_on_day"
  end

  create_table "term_acceptances", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "policy_term_id"
    t.integer "term_version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "invalidated_at"
    t.index ["policy_term_id"], name: "index_term_acceptances_on_policy_term_id"
    t.index ["user_id"], name: "index_term_acceptances_on_user_id"
  end

  create_table "tours", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.bigint "driver_id", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id"
    t.index ["discarded_at"], name: "index_tours_on_discarded_at"
    t.index ["driver_id"], name: "index_tours_on_driver_id"
    t.index ["start_time"], name: "index_tours_on_start_time"
    t.index ["vehicle_id"], name: "index_tours_on_vehicle_id"
  end

  create_table "tours_reports", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "created_by_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id"
    t.index ["company_id"], name: "index_tours_reports_on_company_id"
    t.index ["created_by_id"], name: "index_tours_reports_on_created_by_id"
    t.index ["customer_id"], name: "index_tours_reports_on_customer_id"
  end

  create_table "user_actions", force: :cascade do |t|
    t.string "activity"
    t.bigint "user_id"
    t.string "target_type"
    t.bigint "target_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_type", "target_id"], name: "index_user_actions_on_target_type_and_target_id"
    t.index ["user_id"], name: "index_user_actions_on_user_id"
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
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: "", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicle_activity_assignments", force: :cascade do |t|
    t.bigint "vehicle_id"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_vehicle_activity_assignments_on_activity_id"
    t.index ["vehicle_id"], name: "index_vehicle_activity_assignments_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "name"
    t.datetime "discarded_at"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_vehicles_on_company_id"
    t.index ["discarded_at"], name: "index_vehicles_on_discarded_at"
    t.index ["name"], name: "index_vehicles_on_name"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "companies"
  add_foreign_key "activity_executions", "activities"
  add_foreign_key "activity_executions", "drives", column: "drive_id"
  add_foreign_key "driver_applications", "companies", column: "accepted_to_id"
  add_foreign_key "driver_applications", "users"
  add_foreign_key "driver_applications", "users", column: "accepted_by_id"
  add_foreign_key "driver_logins", "drivers"
  add_foreign_key "driver_logins", "users"
  add_foreign_key "drivers", "companies"
  add_foreign_key "drives", "customers"
  add_foreign_key "drives", "drivers", name: "fk_drives_driver"
  add_foreign_key "drives", "sites"
  add_foreign_key "drives", "tours"
  add_foreign_key "drives", "vehicles"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "site_activity_flat_rates", "activities"
  add_foreign_key "site_activity_flat_rates", "sites"
  add_foreign_key "sites", "customers"
  add_foreign_key "standby_dates", "drivers", name: "fk_standby_dates_driver"
  add_foreign_key "term_acceptances", "policy_terms"
  add_foreign_key "term_acceptances", "users"
  add_foreign_key "tours", "drivers"
  add_foreign_key "tours", "vehicles"
  add_foreign_key "tours_reports", "customers"
  add_foreign_key "user_actions", "users"
  add_foreign_key "vehicle_activity_assignments", "activities"
  add_foreign_key "vehicle_activity_assignments", "vehicles"
end
