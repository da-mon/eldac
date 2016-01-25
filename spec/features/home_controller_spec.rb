
require 'rails_helper'

describe "using the home controller", :type => :feature do

  it 'visits the homepage', :js => true do
    visit root_path
    expect(page).to have_content 'Example headline'
  end

  it 'visits the contact page', :js => true do
    visit contact_path
    expect(page).to have_content 'Contact'
  end

  it 'visits the about page', :js => true do
    visit about_path
    expect(page).to have_content 'About'
  end

end
