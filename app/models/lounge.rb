# frozen_string_literal: true

class Lounge < ApplicationRecord
  belongs_to :lounge_owner

  validates :name, :phone_number, :address_street_1, :city, :state, :zip_code, presence: true
  validates :description, length: { maximum: 500, message: 'is too long (maximum is 500 characters)' }
end
