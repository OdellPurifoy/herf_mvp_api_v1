# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :lounge_owner do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
