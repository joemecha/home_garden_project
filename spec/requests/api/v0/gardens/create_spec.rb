require 'rails_helper'

RSpec.describe 'Gardens Create Endpoint', type: :request do
  let(:user) { create(:user) }
  let(:api_key) { user.api_key }

  describe 'POST /api/v0/gardens' do
    context 'Happy Path' do
      it 'creates a new garden' do
        headers = {"Content-Type": "application/json"}
        request_body = { 
          garden: { 
            name: 'My Garden',
            size: 50.0, 
            user_id: user.id
          } 
        }.to_json

        post "/api/v0/gardens?api_key=#{api_key}", headers:, params: request_body

        new_garden = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(201)

        expected_response = {
          data: {
            attributes: { 
              name: 'My Garden',
              size: 50.0
            },
            id: Garden.last.id.to_s,
            type: 'gardens',
          }
        }

        expect(new_garden).to eq(expected_response)
      end
    end

    context 'Sad Path' do
      it 'returns an error if name is blank' do
        garden_params = { garden: { name: '', size: 10.0, user_id: user.id } }

        post '/api/v0/gardens', params: garden_params.merge(api_key: api_key)

        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq({ errors: ["Name can't be blank"] }.to_json)
      end
    end
  end
end
