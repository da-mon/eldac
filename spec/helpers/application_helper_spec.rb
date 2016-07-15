
require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe 'glyph' do

    it 'will return a glyph name for a symbol' do
      expect(helper.glyph(:records)).to eq('th-list')
      expect(helper.glyph(:projects)).to eq('list-alt')
    end

  end

  describe 'sg' do

    it 'will return a span glyph' do
      expect(helper.sg('foo')).to eq('<span class="glyphicon glyphicon-foo"></span>')
    end

  end

  describe 'dl' do

    it 'will return a delimiter' do
      expect(helper.dl).to eq('&nbsp;↪&nbsp;')
    end

  end

  describe 'active_menu' do

    it 'may return a css class' do
      controller.request.path = 'home'
      expect(helper.active_menu('home')).to eq('active')
      expect(helper.active_menu('not home')).to eq('')
    end

  end

  describe 'logged_in?' do

    let!(:user) { create(:user, :valid_user) }

    it 'will return a bool' do
      expect(helper.logged_in?).to be false
      session[:user_id] = user.id
      expect(helper.logged_in?).to be true
    end

  end

end
