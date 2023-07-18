require 'rails_helper'

RSpec.describe 'Garden Index', type: :request do
  describe 'Happy Path' do
    # TODO: set up test data

    it 'Returns a list of gardens in the database' do
      get '/api/v1/gardens?api_key=abc123'
      garden_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(garden_list[:data]).to be_an(Array)
      expect(garden_list[:data].count).to eq(2)
      expect(garden_list[:data].first[:attributes]).to have_key(:name)
      expect(garden_list[:data].first[:attributes]).to have_key(:size)
    end
  end

  describe 'Sad Path' do
    it 'Returns a message if no gardens in the database' do
      get '/api/v0/gardens?api_key=3aa924'
      portfolio_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(portfolio_list[:message]).to be_a(String)
      expect(portfolio_list[:message]).to eq('You currently have no gardens.')
    end

    it 'Returns an error message if no api key' do
      get '/api/v0/gardens'
      portfolio_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      expect(portfolio_list[:message]).to be_a(String)
      expect(portfolio_list[:message]).to eq('Invalid or missing API key')
    end

    it 'Returns an error message if incorrect api key' do
      get '/api/v0/gardens?api_key=111'
      portfolio_list = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      expect(portfolio_list[:message]).to be_a(String)
      expect(portfolio_list[:message]).to eq('Invalid or missing API key')
    end
  end
end
