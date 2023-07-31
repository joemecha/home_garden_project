require 'rails_helper'

RSpec.describe 'Location Index Endpoint', type: :request do
  let(:locations_index_path) { "/api/v0/gardens/#{garden.id}/locations?api_key=#{user.api_key}" }
  let(:user) { create(:user) }
  let(:api_key) { user.api_key }
  let(:garden) { create(:garden, user:) }

  describe 'Happy Path' do
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

  describe 'Sad Path' do
    it 'Returns an error message if no api key' do
      get "/api/v0/gardens/#{garden.id}/locations"
      location_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      expect(location_list[:message]).to be_a(String)
      expect(location_list[:message]).to eq('Invalid or missing API key')
    end

    it 'Returns an error message if incorrect api key' do
      get "/api/v0/gardens/#{garden.id}/locations?api_key=0"
      location_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      expect(location_list[:message]).to be_a(String)
      expect(location_list[:message]).to eq('Invalid or missing API key')
    end
  end
end
