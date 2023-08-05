require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :request do
  describe 'POST /signup' do
    context 'when valid params are provided' do
      it 'creates a new user' do
        user_params = {
          user: {
            email: 'test@example.com',
            password: 'password',
            password_confirmation: 'password',
            name: 'John Doe',
            zip_code: '12345'
          }
        }.to_json

        post '/signup', params: user_params, headers: { 'Content-Type': 'application/json' }

        expect(response).to be_successful
        expect(response.status).to eq(200)

        new_user = JSON.parse(response.body, symbolize_names: true)

        expect(new_user[:data][:user][:email]).to eq('test@example.com')
        expect(new_user[:data][:user][:name]).to eq('John Doe')
        expect(User.last.time_zone).to_not be(nil)
      end
    end

    context 'when invalid params are provided' do
      it 'returns an error if email is blank' do
        user_params = {
          user: {
            email: '',
            password: 'password',
            password_confirmation: 'password',
            name: 'John Doe',
            zip_code: '12345'
          }
        }.to_json

        post '/signup', params: user_params, headers: { 'Content-Type': 'application/json' }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Email can't be blank")
      end
      # Add more tests for other cases like password mismatch, etc.
    end
  end
end
