require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET "/users/1/posts"' do
    before(:example) { get '/users/1/posts' }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'page contains text' do
      expect(response.body).to include('Here are list of posts by user 1')
    end
  end

  describe 'GET "/users/1/posts/1"' do
    before(:example) { get '/users/1/posts/2' }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      expect(response).to render_template('show')
    end

    it 'page contains text' do
      expect(response.body).to include('Here is a page for post with id 2 by user 1')
    end
  end
end
