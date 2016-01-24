
require 'rails_helper'

RSpec.describe ProjectFolder, type: :model do

  let(:project_folder){ create(:project_folder, :valid_project_folder) }

  describe 'valid project_folder' do

    it 'has a valid factory' do
      expect(project_folder).to be_valid
    end

    it 'should be checked' do
      p = project_folder.project
      f = project_folder.folder
      expect(ProjectFolder.should_be_checked([project_folder], f.id, p)).to be true
      expect(!ProjectFolder.should_be_checked([project_folder], 0, p)).to be true
    end

  end

end
