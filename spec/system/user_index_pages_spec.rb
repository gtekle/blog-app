require 'rails_helper'

RSpec.describe 'UserIndexPages', type: :system do
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

  it 'renders users index page' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'

    visit '/users/'

    expect(page).to have_content 'Logged in as: Test'
    expect(page).to have_css("img[src*='https://png.pngtree.com/png-clipart/20210308/original/pngtree-a-squatting-british-short-blue-and-white-cat-png-image_5794547.jpg']")
    expect(page).to have_content 'Number of posts: 0'

    click_link('Test')

    user = User.find_by(email: 'test@test.com')
    expect(current_path).to eq user_path(user)
    expect(page).to have_css('ul.user-recent-posts')
  end
end
