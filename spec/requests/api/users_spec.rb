require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  path '/api/v1/users' do
    get 'get list of users' do
      tags 'Users'
      consumes 'application/json'

      response '200', 'users fetched' do
        run_test!
      end
    end
  end

  path '/api/v1/users/1' do
    get 'Retrieves a user' do
      tags 'Users', 'User'
      produces 'application/json'

      response '200', 'user found' do
        run_test!
      end
    end
  end
end
