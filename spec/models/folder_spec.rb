
require 'rails_helper'

RSpec.describe Folder, type: :model do

  it_behaves_like 'colorful'

  let!(:valid_folder) { create(:folder, :valid_folder) }

  describe 'valid folder' do

    let!(:red_folder) { create(:folder, :valid_folder, fg: 'ffff00', bg: 'ff0000') }

    it 'has a valid factory' do
      expect(valid_folder).to be_valid
    end

    it 'has a td style' do
      expect(red_folder.td_style).to eq("color: #ffff00;      background:-webkit-linear-gradient(#ff0000, #e50000); background:-o-linear-gradient(#ff0000, #e50000); background:-moz-linear-gradient(#ff0000, #e50000); background:linear-gradient(#ff0000, #e50000); filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#ff0000, endColorstr=#e50000); -ms-filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#ff0000, endColorstr=#e50000);\n")
    end

    it 'has a td a style' do
      expect(red_folder.a_style).to eq('text-decoration: none; color: #ffff00')
    end

  end

end
