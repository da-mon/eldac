
require 'rails_helper'

RSpec.describe User, type: :model do

  let(:valid_user) { create(:user, :valid_user) }

  describe "valid user" do

    let(:owner){ create(:relationship, name: 'owner') }
    let(:user_project){ create(:user_project, relationship: owner) }
    let(:user){ create(:user, :valid_user) }
    let(:project_folder) { create(:project_folder, :valid_project_folder, user: user) }
    let!(:project){ create(:project, :valid_project) }
    let!(:user_project_2){ create(:user_project, project: project, user: user) }

    it 'has a valid factory' do
      expect(valid_user).to be_valid
    end

    it 'can have undeleted projects' do
      u = user_project.user
      p = user_project.project
      expect(u.undeleted_projects).to eq([p])
    end

    it 'can have unfoldered projects' do
      u = project_folder.user
      expect(u.unfoldered_projects.count).to eq(1)
    end

    it 'can have projects in a folder' do
      p = project_folder.project
      f = project_folder.folder
      u = project_folder.user
      expect(u.projects_in(f)).to eq([p])
    end

    it 'can have assigned_projects' do
      p = project_folder.project
      u = project_folder.user
      expect(u.assigned_projects).to eq([p])
    end

    it 'can own a project' do
      u = user_project.user
      p = user_project.project
      expect(u.is_owner?(p)).to eq(user_project)
    end

    it 'can authenticate' do
      user = User.authenticate(valid_user.email, '')
      expect(user).to eq(nil)
      user = User.authenticate(valid_user.email, nil)
      expect(user).to eq(nil)
      user = User.authenticate('', nil)
      expect(user).to eq(nil)
      user = User.authenticate(nil, nil)
      expect(user).to eq(nil)
      user = User.authenticate(valid_user.email, 'changeme')
      expect(user).to eq(valid_user)
    end

    it 'has a fullname' do
      expect(valid_user.fullname).to eq("#{valid_user.fname} #{valid_user.lname}")
    end

    it 'requires a valid email' do
      valid_user.email = nil
      expect(valid_user).to be_invalid
      valid_user.email = ''
      expect(valid_user).to be_invalid
      valid_user.email = 'x@'
      expect(valid_user).to be_invalid
      valid_user.email = '@x'
      expect(valid_user).to be_invalid
    end

    it 'requires a unique email' do
      dupe = build(:user, email: valid_user.email)
      expect(dupe).to be_invalid
    end

    it 'should have downcased email' do
      foo = create(:user, email: 'Foo@baR.Com')
      expect(foo.email).to eq('foo@bar.com')
    end

    it 'should have a valid first name' do
      foo = build(:user, fname: 'x' * 33)
      expect(foo).to be_invalid
      foo = build(:user, fname: '')
      expect(foo).to be_invalid
      foo = build(:user, fname: nil)
      expect(foo).to be_invalid
    end

    it 'should have a valid last name' do
      foo = build(:user, lname: 'x' * 33)
      expect(foo).to be_invalid
      foo = build(:user, lname: '')
      expect(foo).to be_invalid
      foo = build(:user, lname: nil)
      expect(foo).to be_invalid
    end

  end

end
