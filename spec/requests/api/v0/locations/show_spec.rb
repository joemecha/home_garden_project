require 'rails_helper'

RSpec.describe 'Location Show Endpoint', type: :request do
  let(:locations_show_path) { "/api/v0/gardens/#{garden.id}/locations/#{location.id}" }
  let(:user) { create(:user) }
  let(:token) do
    post '/login', params: { user: { email: user.email, password: user.password } }
    JSON.parse(response.body)['token']
  end
  let(:garden) { create(:garden, user:) }
  let(:location) { create(:location, garden:) }
  let(:user_2) { build(:user) }
  let(:garden_2) { create(:garden, user: user_2) }
  let(:location_2) { create(:location, garden: garden_2) }

  before do
    # Include the JWT token in the request headers for all examples
    headers = { 'Authorization' => "Bearer #{token}" }
    @headers_with_token = headers
  end

  describe 'Happy Path' do

    it 'Returns a specific location in the database' do  
      get locations_show_path

      location_details = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(location_details[:data]).to be_a(Hash)
      expect(location_details[:data][:id].to_i).to eq(location.id)
      expect(location_details[:data][:attributes]).to have_key(:name)
      expect(location_details[:data][:attributes]).to have_key(:size)
      expect(location_details[:data][:attributes][:name]).to_not eq(location_2.name)
      expect(location_details[:data][:attributes][:size]).to_not eq(location_2.size)
    end
  end

  describe 'Sad Path' do
    it 'Returns an error if location not found' do
      get "/api/v0/gardens/#{garden.id}/locations/1000"

      location_details = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(location_details[:error]).to be_a(String)
      expect(location_details[:error]).to eq('Cannot find location with ID 1000')
    end

    it 'Returns an error message if requesting a location that does not belong to the current user' do
      get "/api/v0/gardens/#{garden.id}/locations/#{location_2.id}"
      location_details = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(location_details[:error]).to be_a(String)
      expect(location_details[:error]).to eq("Cannot find location with ID #{location_2.id}")
    end
  end
end
