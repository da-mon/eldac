
require 'rails_helper'

describe 'using the sessions controller', :type => :feature do

  describe 'to login' do

    let(:user) { create(:user, :valid_user) }

    it 'anon user fails to login', :js => true do
      expect {
        visit login_path
        expect(page).to have_content 'Login'
        click_on('submit')
        expect(page).to have_content "Login failed"
      }.to change(ActiveRecord::SessionStore::Session, :count)
    end

    it 'unknown user fails to login', :js => true do
      expect {
        visit login_path
        expect(page).to have_content 'Login'
        fill_in('Email', with: Faker::Internet.email)
        click_on('submit')
        expect(page).to have_content 'Login failed'
      }.to change(ActiveRecord::SessionStore::Session, :count)
    end

    it 'login to a user account', :js => true do
      expect {
        visit login_path
        expect(page).to have_content 'Login'
        fill_in('Email', with: user.email)
        fill_in('Password', with: 'changeme')
        click_on('submit')
        expect(page).to have_content "Projects"
      }.to change(ActiveRecord::SessionStore::Session, :count)
    end

  end

  describe 'to logout' do

    let(:user) { create(:user, :valid_user) }

    it 'user logs out', :js => true do
      expect {
        visit logout_path
        expect(page).to have_content 'Login'
      }.to change(ActiveRecord::SessionStore::Session, :count)
    end

  end

end
