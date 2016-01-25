
require 'rails_helper'

describe "using the user controller", :type => :feature do

  it 'signup a new user account', :js => true do
    expect {
      visit new_user_path
      expect(page).to have_content 'Signup'
      click_on('submit')
      click_button('Close')
      expect(page).to have_content "can't be blank"
      fill_in('First Name', with: Faker::Name.first_name)
      click_on('submit')
      click_button('Close')
      expect(page).to have_content "can't be blank"
      fill_in('Last Name', with: Faker::Name.last_name)
      click_on('submit')
      click_button('Close')
      expect(page).to have_content "can't be blank"
      fill_in('Email', with: Faker::Internet.email)
      click_on('submit')
      click_button('Close')
      expect(page).to have_content "can't be blank"
      fill_in('Password', with: 'changeme')
      click_on('submit')
      click_button('Close')
      expect(page).to have_content "doesn't match"
      fill_in('Password Confirmation', with: 'wrong')
      click_on('submit')
      click_button('Close')
      expect(page).to have_content "doesn't match"
      fill_in('Password Confirmation', with: 'changeme')
      click_on('submit')
      expect(page).to have_content "check your email"
      click_button('Close')
    }.to change(User, :count).by(1)
  end

end
