# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lounges', type: :request do
  let(:lounge_owner) { FactoryBot.create(:lounge_owner) }
  let(:lounge) { FactoryBot.create(:lounge, lounge_owner: lounge_owner) }
  let(:valid_attributes) do
    {
      lounge: {
        name: 'Example Lounge',
        phone_number: '123-456-7890',
        address_street_1: '123 Main St',
        address_street_2: 'Suite 100',
        city: 'Example City',
        state: 'EX',
        zip_code: '12345',
        description: 'A cozy place to relax and enjoy.',
        outside_cigars_allowed: true,
        outside_drinks_allowed: false,
        drinks_served: true,
        outside_food_allowed: true,
        food_served: false
      }
    }
  end
  let(:invalid_attributes) do
    {
      lounge: {
        name: '',
        phone_number: '',
        address_street_1: '',
        city: '',
        state: '',
        zip_code: ''
      }
    }
  end

  describe 'GET /index' do
    it 'returns a success response' do
      get lounges_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /show' do
    it 'returns a success response' do
      get lounge_path(lounge)
      expect(response).to have_http_status(:ok)
    end

    it 'returns a not found response for invalid id' do
      get lounge_path(id: 'invalid')
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Lounge' do
        post '/login', params: { lounge_owner: { email: lounge_owner.email, password: lounge_owner.password } },
                       as: :json
        token = response.headers['Authorization']
        expect do
          post lounges_path, params: valid_attributes, headers: { 'Authorization': token }, as: :json
        end.to change(Lounge, :count).by(1)
      end

      it 'returns a created response' do
        post '/login', params: { lounge_owner: { email: lounge_owner.email, password: lounge_owner.password } },
                       as: :json
        token = response.headers['Authorization']
        post lounges_path, params: valid_attributes, headers: { 'Authorization': token }, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Lounge' do
        post '/login', params: { lounge_owner: { email: lounge_owner.email, password: lounge_owner.password } },
                       as: :json
        token = response.headers['Authorization']
        expect do
          post lounges_path, params: invalid_attributes, headers: { 'Authorization': token }, as: :json
        end.to change(Lounge, :count).by(0)
      end

      it 'returns an unprocessable entity response' do
        post '/login', params: { lounge_owner: { email: lounge_owner.email, password: lounge_owner.password } },
                       as: :json
        token = response.headers['Authorization']
        post lounges_path, params: invalid_attributes, headers: { 'Authorization': token }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          lounge: {
            name: 'Updated Lounge',
            phone_number: '987-654-3210'
          }
        }
      end

      it 'updates the requested lounge' do
        post '/login', params: { lounge_owner: { email: lounge_owner.email, password: lounge_owner.password } },
                       as: :json
        token = response.headers['Authorization']
        put lounge_path(lounge), params: new_attributes, headers: { 'Authorization': token }, as: :json
        lounge.reload
        expect(lounge.name).to eq('Updated Lounge')
        expect(lounge.phone_number).to eq('987-654-3210')
      end

      it 'returns a success response' do
        post '/login', params: { lounge_owner: { email: lounge_owner.email, password: lounge_owner.password } },
                       as: :json
        token = response.headers['Authorization']
        put lounge_path(lounge), params: new_attributes, headers: { 'Authorization': token }, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'returns an unprocessable entity response' do
        post '/login', params: { lounge_owner: { email: lounge_owner.email, password: lounge_owner.password } },
                       as: :json
        token = response.headers['Authorization']
        put lounge_path(lounge), params: invalid_attributes, headers: { 'Authorization': token }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested lounge' do
      post '/login', params: { lounge_owner: { email: lounge_owner.email, password: lounge_owner.password } }, as: :json
      token = response.headers['Authorization']
      lounge_to_delete = FactoryBot.create(:lounge, lounge_owner: lounge_owner)
      expect do
        delete lounge_path(lounge_to_delete), headers: { 'Authorization': token }, as: :json
      end.to change(Lounge, :count).by(-1)
    end

    it 'returns a success response' do
      post '/login', params: { lounge_owner: { email: lounge_owner.email, password: lounge_owner.password } }, as: :json
      token = response.headers['Authorization']
      lounge_to_delete = FactoryBot.create(:lounge, lounge_owner: lounge_owner)
      delete lounge_path(lounge_to_delete), headers: { 'Authorization': token }, as: :json
      expect(response).to have_http_status(:ok)
    end
  end
end
