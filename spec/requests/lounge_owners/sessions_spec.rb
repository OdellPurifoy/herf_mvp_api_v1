require 'rails_helper'

RSpec.describe 'LoungeOwners::Sessions', type: :request do
  let(:lounge_owner) { FactoryBot.create(:lounge_owner) }

  describe 'POST /login' do
    let(:valid_credentials) do
      {
        lounge_owner: {
          email: lounge_owner.email,
          password: lounge_owner.password
        }
      }
    end

    let(:invalid_credentials) do
      {
        lounge_owner: {
          email: lounge_owner.email,
          password: 'wrong_password'
        }
      }
    end

    context 'with valid credentials' do
      it 'logs in the lounge owner' do
        post '/login', params: valid_credentials, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Logged in successfully')
      end
    end

    context 'with invalid credentials' do
      it 'returns unauthorized status' do
        post '/login', params: invalid_credentials, as: :json
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('Invalid Email or password.')
      end
    end
  end

  describe 'DELETE /logout' do
    before do
      post '/login', params: { lounge_owner: { email: lounge_owner.email, password: lounge_owner.password } }, as: :json
    end

    it 'logs out the lounge owner' do
      delete '/logout', as: :json
      expect(response).to have_http_status(:unprocessable_content)
    end

    it 'returns no active session if not logged in' do
      delete '/logout', as: :json
      delete '/logout', as: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('No active session')
    end
  end
end
