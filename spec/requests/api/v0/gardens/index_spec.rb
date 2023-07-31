require 'rails_helper'

RSpec.describe 'Gardens Index Endpoint', type: :request do
  describe 'Happy Path' do
    let(:gardens_index_path) { "/api/v0/gardens?api_key=#{user.api_key}" }
    let(:user) { create(:user) }
    let(:api_key) { user.api_key }

    it 'Returns a list of gardens in the database' do
      2.times do
        create(:garden, user:)
      end
      
      get gardens_index_path
      garden_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(garden_list[:data]).to be_an(Array)
      expect(garden_list[:data].count).to eq(2)
      expect(garden_list[:data].first[:attributes]).to have_key(:name)
      expect(garden_list[:data].first[:attributes]).to have_key(:size)
    end

    it 'Returns a message if no gardens in the database' do
      get gardens_index_path
      garden_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(garden_list[:message]).to be_a(String)
      expect(garden_list[:message]).to eq('You currently have no gardens.')
    end
  end

  describe 'Sad Path' do
    it 'Returns an error message if no api key' do
      get '/api/v0/gardens'
      garden_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      expect(garden_list[:message]).to be_a(String)
      expect(garden_list[:message]).to eq('Invalid or missing API key')
    end

    it 'Returns an error message if incorrect api key' do
      get '/api/v0/gardens?api_key=111'
      garden_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      expect(garden_list[:message]).to be_a(String)
      expect(garden_list[:message]).to eq('Invalid or missing API key')
    end
  end
end
