require 'rails_helper'

RSpec.describe Users::SessionsController, type: :request do
  let(:user) { create(:user, email: 'test@example.com', password: 'password') }
  let(:valid_login_params) do
    {
      user: {
        email: user.email,
        password: 'password'
      }
    }.to_json
  end

  describe 'DELETE /logout' do
    context 'when user is logged in' do
      it 'logs out successfully' do
        post '/login', params: valid_login_params, headers: { 'Content-Type': 'application/json' }
        token = headers['Authorization']

        delete '/logout', headers: { 'Authorization': token }

        expect(response).to be_successful
        expect(response.status).to eq(200)

        logout_response = JSON.parse(response.body, symbolize_names: true)

        expect(logout_response[:message]).to eq('Logged out successfully.')
        expect(logout_response[:status]).to eq(200)
      end
    end

    context 'when user is not logged in' do
      it 'returns an error' do
        delete '/logout'

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include("Couldn't find an active session.")
      end
    end
  end
end
