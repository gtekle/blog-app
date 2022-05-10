require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before(:example) { User.delete_all }
  it 'signs user in and out' do
    user = User.create(email: 'test@test.com', name: 'Mr. Test', password: 'password',
                       password_confirmation: 'password')
    user.confirm
    sign_in user
    get root_path
    expect(response).to render_template(:index) # add gem 'rails-controller-testing' to your Gemfile first.

    sign_out user
    get root_path
    expect(response).not_to render_template(:index) # add gem 'rails-controller-testing' to your Gemfile first.
  end
  describe 'GET /users' do
    before(:example) do
      User.delete_all
      user = User.create(email: 'test@test.com', name: 'Mr. Test', password: 'password',
                         password_confirmation: 'password')
      user.confirm
      sign_in user
      get users_path
    end

    after(:example) { User.delete_all }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'page contains text' do
      expect(response.body).to include('ALL USERS')
    end
  end

  describe 'GET /users/1' do
    before(:example) do
      User.delete_all
      user = User.create(name: 'Peter', email: 'peter@example.com', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                         bio: 'A farmer in Tigrai.')
      user.confirm
      sign_in user
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
