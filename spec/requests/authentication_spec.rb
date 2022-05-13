require 'rails_helper'

describe 'Athentication', type: :request do
  describe 'POST /api/auth' do
    it 'authenticates the client' do
      post '/api/v1/auth'
    end
  end
end
