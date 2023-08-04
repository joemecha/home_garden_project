require 'rails_helper'

RSpec.describe 'Gardens Index Endpoint', type: :request do
  describe 'Happy Path' do
    let(:gardens_index_path) { '/api/v0/gardens' }
    let(:user) { create(:user) }
    let(:token) do
      post '/login', params: { user: { email: user.email, password: user.password } }
      JSON.parse(response.body)['token']
    end

    before do
      # Include the JWT token in the request headers for all examples
      headers = { 'Authorization' => "Bearer #{token}" }
      @headers_with_token = headers
    end

    it 'Returns a list of gardens in the database' do
      2.times do
        create(:garden, user: user)
      end

      get gardens_index_path, headers: @headers_with_token
      garden_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(garden_list[:data]).to be_an(Array)
      expect(garden_list[:data].count).to eq(2)
      expect(garden_list[:data].first[:attributes]).to have_key(:name)
      expect(garden_list[:data].first[:attributes]).to have_key(:size)
    end

    it 'Returns a message if no gardens in the database' do
      get gardens_index_path, headers: @headers_with_token
      garden_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(garden_list[:message]).to be_a(String)
      expect(garden_list[:message]).to eq('You currently have no gardens.')
    end
  end

  describe 'Sad Path' do
    it 'Returns an error if the JWT token is invalid' do
      invalid_token = 'invalid_token_here'

      headers = { 'Authorization' => "Bearer #{invalid_token}" }
      get '/api/v0/gardens', headers: headers

      expect(response).not_to be_successful
      expect(response.status).to eq(401)
    end

    it 'Returns an error if the JWT token is missing' do
      # Omitting the 'Authorization' header
      get '/api/v0/gardens'

      expect(response).not_to be_successful
      expect(response.status).to eq(401)
    end
  end
end
