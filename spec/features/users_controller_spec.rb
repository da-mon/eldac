
require 'rails_helper'

describe "users controller", :type => :feature do

  it 'valid user gets created', :js => true do
    expect {
      visit new_user_path
      expect(page).to have_content 'Signup'
      fill_in('First Name', with: Faker::Name.first_name)
      fill_in('Last Name', with: Faker::Name.last_name)
      fill_in('Email', with: Faker::Internet.email)
      fill_in('Password', with: 'changeme')
      fill_in('Password Confirmation', with: 'changeme')
      click_on('submit')
      expect(page).to have_content "check your email"
      expect(page).to have_content 'Close'
    }.to change(User, :count).by(1)
  end

  it 'invalid user password fails', :js => true do
    expect {
      visit new_user_path
      expect(page).to have_content 'Signup'
      fill_in('First Name', with: Faker::Name.first_name)
      fill_in('Last Name', with: Faker::Name.last_name)
      fill_in('Email', with: Faker::Internet.email)
      fill_in('Password', with: 'changeme')
      fill_in('Password Confirmation', with: 'wrong')
      click_on('submit')
      expect(page).to have_content "doesn't match"
      expect(page).to have_content 'Close'
    }.to change(User, :count).by(0)
  end

  it 'missing first name fails', :js => true do
    expect {
      visit new_user_path
      expect(page).to have_content 'Signup'
      fill_in('Last Name', with: Faker::Name.last_name)
      fill_in('Email', with: Faker::Internet.email)
      fill_in('Password', with: 'changeme')
      fill_in('Password Confirmation', with: 'wrong')
      click_on('submit')
      expect(page).to have_content "can't be blank"
      expect(page).to have_content 'Close'
    }.to change(User, :count).by(0)
  end

  it 'missing last name fails', :js => true do
    expect {
      visit new_user_path
      expect(page).to have_content 'Signup'
      fill_in('First Name', with: Faker::Name.first_name)
      fill_in('Email', with: Faker::Internet.email)
      fill_in('Password', with: 'changeme')
      fill_in('Password Confirmation', with: 'wrong')
      click_on('submit')
      expect(page).to have_content "can't be blank"
      expect(page).to have_content 'Close'
    }.to change(User, :count).by(0)
  end

  it 'missing email fails', :js => true do
    expect {
      visit new_user_path
      expect(page).to have_content 'Signup'
      fill_in('First Name', with: Faker::Name.first_name)
      fill_in('Last Name', with: Faker::Name.last_name)
      fill_in('Password', with: 'changeme')
      fill_in('Password Confirmation', with: 'wrong')
      click_on('submit')
      expect(page).to have_content "can't be blank"
      expect(page).to have_content 'Close'
    }.to change(User, :count).by(0)
  end

  it 'missing password fails', :js => true do
    expect {
      visit new_user_path
      expect(page).to have_content 'Signup'
      fill_in('First Name', with: Faker::Name.first_name)
      fill_in('Last Name', with: Faker::Name.last_name)
      fill_in('Email', with: Faker::Internet.email)
      # fill_in('Password', with: 'changeme')
      # fill_in('Password Confirmation', with: 'wrong')
      click_on('submit')
      expect(page).to have_content "can't be blank"
      expect(page).to have_content 'Close'
    }.to change(User, :count).by(0)
  end

  it 'missing password confirmation fails', :js => true do
    expect {
      visit new_user_path
      expect(page).to have_content 'Signup'
      fill_in('First Name', with: Faker::Name.first_name)
      fill_in('Last Name', with: Faker::Name.last_name)
      fill_in('Email', with: Faker::Internet.email)
      fill_in('Password', with: 'changeme')
      # fill_in('Password Confirmation', with: 'wrong')
      click_on('submit')
      expect(page).to have_content "doesn't match"
      expect(page).to have_content 'Close'
    }.to change(User, :count).by(0)
  end

end
