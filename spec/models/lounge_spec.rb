# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lounge, type: :model do
  let(:lounge_owner) { FactoryBot.create(:lounge_owner) }
  let(:lounge) { FactoryBot.build(:lounge, lounge_owner: lounge_owner) }

  describe 'associations' do
    it { should belong_to(:lounge_owner) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:address_street_1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it {
      should validate_length_of(:description).is_at_most(500).with_message('is too long (maximum is 500 characters)')
    }
  end

  describe 'valid lounge' do
    it 'is valid with valid attributes' do
      expect(lounge).to be_valid
    end

    it 'is not valid without a name' do
      lounge.name = nil
      expect(lounge).to_not be_valid
    end

    it 'is not valid without a phone_number' do
      lounge.phone_number = nil
      expect(lounge).to_not be_valid
    end

    it 'is not valid without an address_street_1' do
      lounge.address_street_1 = nil
      expect(lounge).to_not be_valid
    end

    it 'is not valid without a city' do
      lounge.city = nil
      expect(lounge).to_not be_valid
    end

    it 'is not valid without a state' do
      lounge.state = nil
      expect(lounge).to_not be_valid
    end

    it 'is not valid without a zip_code' do
      lounge.zip_code = nil
      expect(lounge).to_not be_valid
    end

    it 'is not valid with a description longer than 500 characters' do
      lounge.description = 'a' * 501
      expect(lounge).to_not be_valid
    end
  end
end
