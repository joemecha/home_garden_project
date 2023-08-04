require 'rails_helper'

RSpec.describe 'Location Index Endpoint', type: :request do
  describe 'Happy Path' do
    let(:locations_index_path) { "/api/v0/gardens/#{garden.id}/locations" }
    let(:user) { create(:user) }
    let(:token) do
      post '/login', params: { user: { email: user.email, password: user.password } }
      JSON.parse(response.body)['token']
    end
    let(:garden) { create(:garden, user:) }

    before do
      # Include the JWT token in the request headers for all examples
      headers = { 'Authorization' => "Bearer #{token}" }
      @headers_with_token = headers
    end

    it 'Returns a list of locations in the database' do
      2.times do
        create(:location, garden:)
      end
      
      get locations_index_path
      location_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(location_list[:data]).to be_an(Array)
      expect(location_list[:data].count).to eq(2)
      expect(location_list[:data].first[:attributes]).to have_key(:name)
      expect(location_list[:data].first[:attributes]).to have_key(:size)
    end

    it 'Returns a message if no locations in the database' do
      get locations_index_path
      location_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(location_list[:message]).to be_a(String)
      expect(location_list[:message]).to eq('You currently have no locations.')
    end
  end
end
