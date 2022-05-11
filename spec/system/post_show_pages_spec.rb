require 'rails_helper'

RSpec.describe 'PostShowPages', type: :system do
  #  Post Show page System spec
  before :all do
    # Comment the line below this to see selinium open chrome browser
    driven_by(:rack_test)

    User.delete_all
    # Sign up
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
    click_link 'POST TITLE ONE'
    fill_in 'Comment', with: 'This is my first comment'
    find('input[name="commit"]').click

    expect(current_path).to eq user_post_path(user, post)
    expect(page).to have_content 'Post'
    expect(page).to have_content "Post title one - By #{user.name}"
    expect(page).to have_content 'Post body one'
    expect(page).to have_content 'comments: 1, likes: 0'
    expect(page).to have_content "#{user.name}: This is my first comment"
  end
end
