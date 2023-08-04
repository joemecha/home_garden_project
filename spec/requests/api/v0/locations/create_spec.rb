require 'rails_helper'

RSpec.describe 'Locations Create Endpoint', type: :request do
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
  let(:garden) { create(:garden, user:) }

  describe 'POST /api/v0/gardens/:id/locations' do
    context 'Happy Path' do
      it 'creates a new location' do
        headers = {"Content-Type": "application/json"}

        post '/login', params: { user: { email: user.email, password: user.password } }

        request_body = { 
          location: { 
            name: 'Backyard raised bed',
            size: 25.0,
            irrigated: true,
            garden_id: garden.id
          } 
        }.to_json

        post "/api/v0/gardens/#{garden.id}/locations", headers:, params: request_body

        new_location = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(201)

        expected_response = {
          data: {
            attributes: { 
              name: 'Backyard raised bed',
              size: 25.0,
              irrigated: true,
            },
            id: Location.last.id.to_s,
            type: 'locations',
          }
        }

        expect(new_location).to eq(expected_response)
      end
    end

    context 'Sad Path' do
      it 'returns an error if name is blank' do
        location_params = { location: { name: '', size: 25.0, irrigated: true, garden_id: garden.id } }

        post "/api/v0/gardens/#{garden.id}/locations", params: location_params

        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq({ errors: ["Name can't be blank"] }.to_json)
      end
    end
  end
end
