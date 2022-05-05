require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(name: 'Peter',
                  photo: 'photo_url',
                  bio: 'This is a bio for Mr. Peter!',
                  posts_counter: 0)

  before(:all) { user.save }

  describe 'validate data: ' do
    it 'name should be present' do
      user.name = ''
      expect(user).to_not be_valid
    end

    it 'posts_counter should be greater than or equal to zero' do
      user.name = 'John'
      user.posts_counter = -1
      expect(user).to_not be_valid
    end

    it 'posts_counter value should be positive integer' do
      user.name = 'John'
      user.posts_counter = 'one'
      expect(user).to_not be_valid
    end
  end

  describe 'most_recent_posts method' do
    before do
      Post.create(author_id: user.id, title: 'post-title1', text: 'post body one')
      Post.create(author_id: user.id, title: 'post-title2', text: 'post body two')
      Post.create(author_id: user.id, title: 'post-title3', text: 'post body three')
      Post.create(author_id: user.id, title: 'post-title4', text: 'post body four')
    end

    it 'should return three latest posts' do
      expect(user.most_recent_posts.length).to eq(3)
      expect(user.most_recent_posts[0].title).to eq 'post-title4'
    end
  end
end
