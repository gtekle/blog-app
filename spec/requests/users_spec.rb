require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    before(:example) { get users_path }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'page contains text' do
      expect(response.body).to include('All Users')
    end
  end

  describe 'GET /users/1' do
    before(:example) do
      user = User.create(name: 'Peter', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'A farmer in Tigrai.')
      get "/users/#{user.id}"
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      expect(response).to render_template('show')
    end

    it 'page contains text' do
      expect(response.body).to include('Peter')
    end
  end
end
