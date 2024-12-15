# frozen_string_literal: true

class CreateLounges < ActiveRecord::Migration[7.1]
  def change
    create_table :lounges do |t|
      t.string :name, null: false
      t.string :email
      t.string :phone_number, null: false
      t.string :address_street_1, null: false
      t.string :address_street_2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code, null: false
      t.text :description
      t.boolean :outside_cigars_allowed, default: false
      t.boolean :outside_drinks_allowed, default: false
      t.boolean :drinks_served, default: false
      t.boolean :outside_food_allowed, default: false
      t.boolean :food_served, default: false
      t.references :lounge_owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
