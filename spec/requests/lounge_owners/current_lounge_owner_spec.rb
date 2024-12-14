require 'rails_helper'

RSpec.describe 'LoungeOwners::CurrentLoungeOwner', type: :request do
  let(:lounge_owner) { FactoryBot.create(:lounge_owner) }

  describe 'GET /lounge_owners/current_lounge_owner' do
    context 'when logged in' do
      before do
        post '/login', params: { lounge_owner: { email: lounge_owner.email, password: lounge_owner.password } },
                       as: :json
        @token = response.headers['Authorization']
      end

      it 'returns the current lounge owner' do
        get '/lounge_owners/current_lounge_owner', headers: { 'Authorization': @token }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(lounge_owner.email)
      end
    end

    context 'when not logged in' do
      it 'returns unauthorized status' do
        get '/lounge_owners/current_lounge_owner', as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
