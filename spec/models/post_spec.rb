require 'rails_helper'

RSpec.describe Post, type: :model do
  first_user = User.new(name: 'Peter',
                        photo: 'photo_url',
                        bio: 'This is a bio for Mr. Peter!',
                        posts_counter: 0)
  first_user.save

  first_post = Post.new(author_id: first_user.id, title: 'post-title1', text: 'post body one')

  before(:all) { first_post.save }

  describe 'validate data: ' do
    it 'title should be present' do
      first_post.title = ''
      expect(first_post).to_not be_valid
    end

    it 'title length should be less than 250 characters' do
      first_post.title = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
      Aliquam pellentesque risus nisi, et malesuada nisl vestibulum id. Curabitur
      scelerisque, turpis vulputate suscipit viverra, elit tellus tincidunt est,
      sit amet finibus augue est vitae urna. Aenean rhoncus quis augue eu pulvinar.'
      expect(first_post).to_not be_valid
    end

    it 'comments_counter should be greater than or equal to zero' do
      first_post.title = 'post-title1'
      first_post.comments_counter = -1
      expect(first_post).to_not be_valid
    end

    it 'comments_counter value should be integer' do
      first_post.title = 'post-title1'
      first_post.comments_counter = 'one'
      expect(first_post).to_not be_valid
    end
    it 'likes_counter should be greater than or equal to zero' do
      first_post.title = 'post-title1'
      first_post.comments_counter = 1
      first_post.likes_counter = -1
      expect(first_post).to_not be_valid
    end

    it 'likes_counter value should be integer' do
      first_post.title = 'post-title1'
      first_post.comments_counter = 1
      expect(first_post).to_not be_valid
    end
  end

  describe 'most_recent_posts method' do
    post = Post.first

    before do
      post.comments.create(author_id: first_user.id, text: 'comment one')
      post.comments.create(author_id: first_user.id, text: 'comment two')
      post.comments.create(author_id: first_user.id, text: 'comment three')
      post.comments.create(author_id: first_user.id, text: 'comment four')
      post.comments.create(author_id: first_user.id, text: 'comment five')
      post.comments.create(author_id: first_user.id, text: 'comment six')
      post.comments.create(author_id: first_user.id, text: 'comment seven')
      post.comments.create(author_id: first_user.id, text: 'comment eight')
    end

    it 'should return up to five latest comments' do
      expect(post.most_recent_comments.length).to be <= 5
      expect(post.most_recent_comments[0].text).to eq 'comment eight'
    end
  end
end
