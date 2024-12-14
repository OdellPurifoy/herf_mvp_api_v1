require 'rails_helper'

RSpec.describe 'LoungeOwners::Registrations', type: :request do
  describe 'POST /signup' do
    let(:valid_attributes) do
      {
        lounge_owner: {
          email: Faker::Internet.email,
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end

    let(:invalid_attributes) do
      {
        lounge_owner: {
          email: 'invalid_email',
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end

    context 'with valid parameters' do
      it 'creates a new LoungeOwner' do
        expect do
          post '/signup', params: valid_attributes, as: :json
        end.to change(LoungeOwner, :count).by(1)
      end

      it 'returns a success response' do
        post '/signup', params: valid_attributes, as: :json
        expect(response).to have_http_status(:created)
        expect(response.body).to include('Signed up successfully')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new LoungeOwner' do
        expect do
          post '/signup', params: invalid_attributes, as: :json
        end.to change(LoungeOwner, :count).by(0)
      end

      it 'returns an unprocessable entity response' do
        post '/signup', params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Email is invalid')
      end
    end
  end
end
