# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :lounge do
    name { Faker::Company.name }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
    address_street_1 { Faker::Address.street_address }
    address_street_2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip_code { Faker::Address.zip_code }
    description { Faker::Lorem.paragraph }
    outside_cigars_allowed { false }
    outside_drinks_allowed { false }
    drinks_served { false }
    outside_food_allowed { false }
    food_served { false }
    lounge_owner
  end
end
