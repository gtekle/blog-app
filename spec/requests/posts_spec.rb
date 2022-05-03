require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET "/users/1/posts"' do
    before(:example) do
      user = User.create(name: 'Peter', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'A farmer in Tigrai.')
      Post.create(author: user, title: 'Hello', text: 'This is my first post')
      get "/users/#{user.id}/posts"
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'page contains text' do
      expect(response.body).to include('Peter')
    end
  end

  describe 'GET "/users/1/posts/9"' do
    before(:example) do
      user = User.create(name: 'Peter', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'A farmer in Tigrai.')
      post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
      get "/users/#{user.id}/posts/#{post.id}"
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      expect(response).to render_template('show')
    end

    it 'page contains text' do
      expect(response.body).to include('Post')
    end
  end
end
