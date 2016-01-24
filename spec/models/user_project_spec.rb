require 'rails_helper'

RSpec.describe UserProject, type: :model do

  let(:valid_user_project){ create(:user_project, :valid_user_project) }

  describe 'valid user_project' do
    it 'has a valid factory' do
      expect(valid_user_project).to be_valid
    end
  end

end
