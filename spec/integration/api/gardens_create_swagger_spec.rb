# require 'swagger_helper'

# RSpec.describe 'Gardens Create Endpoint', type: :request do
#   let(:user) { create(:user) }

#   path '/api/v0/gardens' do
#     post 'Creates a garden' do
#       tags 'Gardens'
#       consumes 'application/json'
#       parameter name: :garden, in: :body, schema: {
#         type: :object,
#         properties: {
#           name: { type: :string },
#           size: { type: :number },
#           user_id: { type: :integer }
#         },
#         required: ['name', 'size', 'user_id']
#       }

#       response '201', 'garden created' do
#         let(:garden) { { name: 'foo', size: 10.5, user_id: user.id } }
#         run_test!
#       end

#       response '400', 'bad request' do
#         let(:garden) { { name: 'foo' } }

#         examples 'application/json': {
#           errors: ['Name can\'t be blank']
#         }
#         run_test!
#       end
#     end
#   end
# end
