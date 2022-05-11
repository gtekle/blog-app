require 'rails_helper'

RSpec.describe 'UserPostsIndexPages', type: :system do
  before :all do
    # Comment the line below this to see selinium open chrome browser
    driven_by(:rack_test)

    User.delete_all
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Name', with: 'Test'
      fill_in 'Photo', with: 'https://png.pngtree.com/png-clipart/20210308/original/pngtree-a-squatting-british-short-blue-and-white-cat-png-image_5794547.jpg'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'
    end
    user = User.find_by(email: 'test@test.com')
    user.confirm
  end

  it 'renders user post index page' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'

    visit '/users/'
    click_link('Test')

    click_link('create new post')
    fill_in 'Title', with: 'Post title one'
    fill_in 'Text', with: 'Post body one'
    find('input[name="commit"]').click

    user = User.find_by(email: 'test@test.com')
    post = Post.find_by(title: 'Post title one')

    visit '/users/'
    click_link('Test')
    click_link 'See all posts'

    expect(current_path).to eq user_posts_path(user)
    expect(page).to have_content 'Number of posts: 1'
    expect(page).to have_link 'create new post'
    expect(page).to have_css('ul.post-comments-list')
    expect(page).to have_css('a', text: 'POST TITLE ONE')
    expect(page).to have_css("img[src*='https://png.pngtree.com/png-clipart/20210308/original/pngtree-a-squatting-british-short-blue-and-white-cat-png-image_5794547.jpg']")

    click_link 'POST TITLE ONE'
    fill_in 'Comment', with: 'This is my first comment'
    find('input[name="commit"]').click

    visit user_posts_path(user)
    expect(page).to have_content "#{user.name}: This is my first comment"

    click_link 'POST TITLE ONE'
    expect(current_path).to eq user_post_path(user, post)
  end
end
