# require 'swagger_helper'

# RSpec.describe 'Gardens Index Endpoint', swagger_doc: 'v1/swagger.json', type: :request do
#   path '/api/v0/gardens' do
#     get 'Returns a list of gardens in the database' do
#       let(:user) { create(:user) }

#       tags 'Gardens'
#       consumes 'application/json'

#       response '200', 'list of gardens' do
#         schema type: :object,
#                properties: {
#                  data: {
#                    type: :array,
#                    items: {
#                      type: :object,
#                      properties: {
#                        attributes: {
#                          type: :object,
#                          properties: {
#                            name: { type: :string },
#                            size: { type: :number }
#                          },
#                          required: %w[name size]
#                        }
#                      }
#                    }
#                  }
#                }
#         examples 'application/json': {
#           data: [
#             { attributes: { name: 'Garden 1', size: 10.0 } },
#             { attributes: { name: 'Garden 2', size: 20.0 } }
#           ]
#         }

#         run_test!
#       end

#       response '401', 'Unauthorized' do
#         schema type: :object,
#                properties: {
#                  message: { type: :string }
#                }
#         examples 'application/json': {
#           message: 'Invalid or missing API key'
#         }

#         run_test!
#       end
#     end
#   end
# end
