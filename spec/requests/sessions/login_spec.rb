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

  describe 'POST /login' do
    context 'when valid credentials are provided' do
      it 'logs in successfully and returns a token' do
        post '/login', params: valid_login_params, headers: { 'Content-Type': 'application/json' }
        expect(response).to be_successful
        expect(response.status).to eq(200)
        
        login_response = JSON.parse(response.body, symbolize_names: true)

        expect(login_response[:data][:user][:email]).to eq(user.email)
        expect(login_response[:status][:message]).to eq('Logged in successfully.')
        expect(login_response[:status][:code]).to eq(200)
      end
    end

    context 'when invalid credentials are provided' do
      it 'returns an error' do
        invalid_login_params = {
          user: {
            email: 'invalid@example.com',
            password: 'invalidpassword'
          }
        }.to_json

        post '/login', params: invalid_login_params, headers: { 'Content-Type': 'application/json' }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body.downcase).to include('invalid email or password')
      end
    end
  end
end
