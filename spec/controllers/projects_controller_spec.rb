
require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe 'POST #toggle_folder' do

    let(:user) { create(:user, :valid_user) }
    let(:folder) { create(:folder, :valid_folder, user: user) }
    let(:project) { create(:project, :valid_project) }
    let(:owner) { create(:relationship, name: 'owner') }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: owner) }

    it 'redirects anon users' do
      post :toggle_folder
      expect(response).to have_http_status(:redirect)
    end

    it 'valid toggle renders nothing' do
      expect {
        post :toggle_folder, { folder_id: folder.id, project_ids: [project.id] }, { user_id: user.id }
      }.to change(ProjectFolder, :count).by(1)
      expect(response).to render_template(nil)

      expect {
        post :toggle_folder, { folder_id: folder.id, project_ids: [project.id] }, { user_id: user.id }
      }.to change(ProjectFolder, :count).by(-1)
      expect(response).to render_template(nil)
    end

  end

  describe 'POST #checkall_folder' do

    let(:user) { create(:user, :valid_user) }
    let(:folder) { create(:folder, :valid_folder, user: user) }
    let(:project) { create(:project, :valid_project) }
    let(:owner) { create(:relationship, name: 'owner') }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: owner) }

    it 'redirects anon users' do
      post :checkall_folder
      expect(response).to have_http_status(:redirect)
    end

    it 'valid check all renders nothing' do
      expect {
        post :checkall_folder, { checkall: 1, folder_id: folder.id, project_ids: [project.id] }, { user_id: user.id }
      }.to change(ProjectFolder, :count).by(1)
      expect(response).to render_template(nil)

      expect {
        post :checkall_folder, { checkall: 0, folder_id: folder.id, project_ids: [project.id] }, { user_id: user.id }
      }.to change(ProjectFolder, :count).by(-1)
      expect(response).to render_template(nil)
    end

  end

  describe 'POST #assigned_folder' do

    let(:user) { create(:user, :valid_user) }

    it 'redirects anon users' do
      post :assigned_folder
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects when valid' do
      expect {
        post :assigned_folder, { assigned: 1 }, { user_id: user.id }
      }.to change{ session[:organize_assigned] }
      expect(response).to render_template('folders/_projects_list')
    end

  end

  describe 'GET #organize' do

    let(:user) { create(:user, :valid_user) }

    it 'redirects anon users' do
      get :organize
      expect(response).to have_http_status(:redirect)
    end

    it 'valid user returns http success' do
      get :organize, {}, { user_id: user.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:organize)
      expect(response).to render_template(:main)
    end

  end

  describe 'GET #index' do

    let(:user) { create(:user, :valid_user) }
    let(:user2) { create(:user, :valid_user) }
    let!(:project_folder){ create(:project_folder, :valid_project_folder, user: user2) }

    it 'redirects anon users' do
      get :index
      expect(response).to have_http_status(:redirect)
    end

    it 'valid user returns http success' do
      get :index, {}, { user_id: user.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response).to render_template(:main)
    end

    it 'valid user with organized folders returns http success' do
      get :index, {}, { user_id: user2.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response).to render_template(:main)
    end

  end

  describe 'GET #new' do

    let(:user) { create(:user, :valid_user) }

    it 'redirects anon users' do
      get :new
      expect(response).to have_http_status(:redirect)
    end

    it 'valid user returns http success' do
      get :new, {}, { user_id: user.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
      expect(response).to render_template(:main)
    end

  end

  describe 'GET #edit' do

    let(:user) { create(:user, :valid_user) }
    let(:user2) { create(:user, :valid_user) }
    let(:project) { create(:project, :valid_project) }
    let(:owner) { create(:relationship, name: 'owner') }
    let!(:user_project ) { create(:user_project, user: user, project: project, relationship: owner) }

    it 'redirects anon users' do
      get :edit, { id: 0 }
      expect(response).to have_http_status(:redirect)
    end

    it 'valid user returns http success' do
      get :edit, { id: project.id }, { user_id: user.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
      expect(response).to render_template(:main)
    end

    it 'not owner returns http redirect' do
      get :edit, { id: project.id }, { user_id: user2.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid project id redirects' do
      get :edit, { id: 0 }, { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

  end

  describe 'GET #ask_delete' do

    let(:user) { create(:user, :valid_user) }
    let(:user2) { create(:user, :valid_user) }
    let(:project) { create(:project, :valid_project) }
    let(:owner) { create(:relationship, name: 'owner') }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: owner) }

    it 'redirects anon users' do
      get :ask_delete, { id: 0 }
      expect(response).to have_http_status(:redirect)
    end

    it 'valid user returns http success' do
      get :ask_delete, { id: project.id }, { user_id: user.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:ask_delete)
      expect(response).to render_template(:main)
    end

    it 'not owner returns http redirect' do
      get :ask_delete, { id: project.id }, { user_id: user2.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid project id redirects' do
      get :ask_delete, { id: 0 }, { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

  end

  describe 'POST #create' do

    let(:user) { create(:user, :valid_user) }
    let!(:owner) { create(:relationship, name: 'owner') }

    it 'returns form on error' do
      expect {
        post :create, { :project => { :name => '' } }, { user_id: user.id }
      }.to change(Project, :count).by(0)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
      expect(response).to render_template(:main)
    end

    it 'redirects when valid' do
      expect {
        post :create, { project: { name: 'New Name' } }, { user_id: user.id }
      }.to change(Project, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects anon user' do
      expect {
        post :create, { name: 'New Name' }, {}
      }.to change(Project, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

  end

  describe 'PUT #update' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project, :valid_project) }
    let(:owner) { create(:relationship, name: 'owner') }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: owner) }
    let(:user2) { create(:user, :valid_user) }

    it 'renders form on invalid update' do
      expect {
        put :update, { id: project.id, project: { name: '' } }, { user_id: user.id }
        project.reload
      }.to_not change{ project.name }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
      expect(response).to render_template(:main)
    end

    it 'redirects on valid update' do
      expect {
        put :update, { id: project.id, project: { name: 'Updated Name' } }, { user_id: user.id }
        project.reload
      }.to change{ project.name }
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects on invalid project' do
      expect {
        put :update, { id: 0, name: 'Updated Name' }, { user_id: user.id }
        project.reload
      }.to_not change{ project.name }
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects on invalid project owner' do
      expect {
        put :update, { id: project.id, name: 'Updated Name' }, { user_id: user2.id }
        project.reload
      }.to_not change{ project.name }
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects on anon user' do
      expect {
        put :update, { id: project.id, name: 'Updated Name' }, {}
        project.reload
      }.to_not change{ project.name }
      expect(response).to have_http_status(:redirect)
    end

  end

  describe 'DELETE #destroy' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project, :valid_project) }
    let(:owner) { create(:relationship, name: 'owner') }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: owner) }
    let(:user2) { create(:user, :valid_user) }

    it 'redirects on valid project owner' do
      expect {
        delete :destroy, { id: project.id }, { user_id: user.id }
        project.reload
      }.to change{ project.deleted }
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects on invalid project owner' do
      expect {
        delete :destroy, { id: project.id }, { user_id: user2.id }
        project.reload
      }.to change(Project, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects on anon user' do
      expect {
        delete :destroy, { id: project.id }, {}
      }.to change(Project, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

  end

end
