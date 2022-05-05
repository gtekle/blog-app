require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new({
                    name: 'Peter',
                    photo: 'photo_url',
                    bio: 'This is a bio for Mr. Peter!',
                    posts_counter: 0
                  })

  before { user.save }

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
    user1 = User.first

    before do
      user1.posts.create(title: 'post-title1', text: 'post body one')
      user1.posts.create(title: 'post-title2', text: 'post body two')
      user1.posts.create(title: 'post-title3', text: 'post body three')
      user1.posts.create(title: 'post-title4', text: 'post body four')
    end

    it 'should return up to three latest posts' do
      expect(user1.most_recent_posts.length).to be <= 3
      expect(user1.most_recent_posts[0].title).to eq 'post-title4'
    end
  end
end
