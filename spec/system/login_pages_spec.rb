require 'rails_helper'

RSpec.describe "LoginPages", type: :system do
  before(:all) do
    # Comment the line below this to see selinium open chrome browser
    # driven_by(:rack_test)

    User.delete_all
    visit '/users/sign_up'
    within("#new_user") do
      fill_in 'Email', with: 'tekle@test.com'
      fill_in 'Name', with: 'Tekle'
      fill_in 'Photo', with: 'https://png.pngtree.com/png-clipart/20210308/original/pngtree-a-squatting-british-short-blue-and-white-cat-png-image_5794547.jpg'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'
    end
    user = User.find_by(email: "tekle@test.com");
    user.confirm
  end

  it "renders sign in page" do
    visit '/users/sign_in'
    
    expect(page).to have_field('user_email')
    expect(page).to have_field('user_password')
    expect(page).to have_button('Log in')
  end

  it "Error: Invalid Email or password with empty email and password" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it "Error: Invalid Email or password with empty email and password" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: 'tekle@example.com'
      fill_in 'Password', with: '123456'
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it "signs me in with valid email and password" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: 'tekle@test.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Logged in as: Tekle'
  end
end
