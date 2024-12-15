# frozen_string_literal: true

class LoungeSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :phone_number, :address_street_1, :address_street_2, :city, :state, :zip_code, :description, # rubocop:disable Naming/VariableNumber
             :lounge_owner_id
end
