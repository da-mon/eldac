
require 'rails_helper'

describe "using the home controller", :type => :feature do

  it 'visits the homepage', :js => true do
    visit '/'
    expect(page).to have_content 'Example headline'
  end

end
