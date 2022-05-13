require 'rails_helper'

RSpec.describe 'Athentication', type: :request do
  describe 'POST /apit/auth' do
    it 'authenticates the client' do
      post '/api/v1/auth'
    end
  end
end
