require 'rails_helper'

describe 'Athentication', type: :request do
  let(:user) { FactoryBot.create(:user, name: 'Tekle', email: 'teklegy@gmail.com', password: 'password') }

  describe 'POST /api/auth' do
    it 'authenticates the client' do
      post '/api/v1/auth', params: { email: user.email, password: user.password }

      expect(response).to have_http_status(:created)

      token = JSON.parse(response.body)['token']

      expect { JWT.decode(token, AuthenticationTokenService::HMAC_SECRET) }.to_not raise_error(JWT::DecodeError)
    end

    it 'returns error when email is missing' do
      post '/api/v1/auth', params: { password: '123456' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON(response.body)).to eq({ 'error' => 'param is missing or the value is empty: email' })
    end

    it 'returns error when password is missing' do
      post '/api/v1/auth', params: { email: 'teklegy@gmail.com' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON(response.body)).to eq({ 'error' => 'param is missing or the value is empty: password' })
    end

    it 'returns error when password is incorrect' do
      post '/api/v1/auth', params: { email: user.email, password: '123456' }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
