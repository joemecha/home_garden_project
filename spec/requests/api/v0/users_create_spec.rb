require 'rails_helper'

describe 'user create request' do
  headers = {'Content-Type': 'application/json'}
  user_create_path = '/api/v0/users'
  
  describe 'happy path' do
    it 'Creates a user in the database, encrypts password, and responds with API key' do
      User.destroy_all
      body = {
        'name': "#{ Faker::Name.name }",
        'email_address': "#{ Faker::Internet.email }",
        'password': 'somepassword23',
        'password_confirmation': 'somepassword23'
      }

      post user_create_path, headers: headers, params: body.to_json
      
      new_user = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(new_user[:data].class).to eq(Hash)
      expect(new_user[:data].keys).to eq( %i[id type attributes])
      expect(new_user[:data].keys.size).to eq(3)
      expect(new_user[:data][:attributes].keys).to eq( %i[email_address api_key])
    end

    describe 'sad path' do
      it 'Does not create a new user if email blank' do
        body = {
          'name': "#{ Faker::Name.name }",
          'email_address': '',
          'password': 'somepassword23',
          'password_confirmation': 'somepassword23'
        }

        post user_create_path, headers: headers, params: body.to_json
        
        new_user = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        expect(new_user).to be_a(Hash)
        expect(new_user[:errors]).to eq('Email address cannot be blank')
      end
    
      it 'Does not create a new user if passwords do not match' do
        body = {
          'name': "#{ Faker::Name.name }",
          'email_address': "#{ Faker::Internet.email }",
          'password': 'somepassword23',
          'password_confirmation': 'otherpassword23'
        }

        post user_create_path, headers: headers, params: body.to_json
        
        new_user = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        expect(new_user).to be_a(Hash)
        expect(new_user[:errors]).to eq('Passwords do not match')
      end
    end
  end
end