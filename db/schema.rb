# frozen_string_literal: true

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

ActiveRecord::Schema[7.1].define(version: 20_241_214_230_218) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'lounge_owners', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'jti', null: false
    t.index ['email'], name: 'index_lounge_owners_on_email', unique: true
    t.index ['jti'], name: 'index_lounge_owners_on_jti', unique: true
    t.index ['reset_password_token'], name: 'index_lounge_owners_on_reset_password_token', unique: true
  end

  create_table 'lounges', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email'
    t.string 'phone_number', null: false
    t.string 'address_street_1', null: false
    t.string 'address_street_2'
    t.string 'city', null: false
    t.string 'state', null: false
    t.string 'zip_code', null: false
    t.text 'description'
    t.boolean 'outside_cigars_allowed', default: false
    t.boolean 'outside_drinks_allowed', default: false
    t.boolean 'drinks_served', default: false
    t.boolean 'outside_food_allowed', default: false
    t.boolean 'food_served', default: false
    t.bigint 'lounge_owner_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['lounge_owner_id'], name: 'index_lounges_on_lounge_owner_id'
  end

  add_foreign_key 'lounges', 'lounge_owners'
end
