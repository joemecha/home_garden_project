require 'rails_helper'

RSpec.describe 'Gardens Create Endpoint', type: :request do
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

  describe 'POST /api/v0/gardens', swagger_doc: 'v0/swagger.json' do
    context 'Happy Path' do
      it 'creates a new garden' do
        headers = {"Content-Type": "application/json"}

        post '/login', params: { user: { email: user.email, password: user.password } }

        request_body = { 
          garden: { 
            name: 'My Garden',
            size: 50.0, 
            user_id: user.id
          } 
        }.to_json

        post "/api/v0/gardens", headers:, params: request_body

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

        post '/api/v0/gardens', params: garden_params

        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq({ errors: ["Name can't be blank"] }.to_json)
      end
    end
  end
end
