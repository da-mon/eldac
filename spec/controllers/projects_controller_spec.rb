
require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  context 'default' do

    let(:user) { create(:user, :valid_user) }
    let!(:owner) { create(:relationship, name: 'owner') }

    describe 'POST #toggle_folder' do

      let(:folder) { create(:folder, :valid_folder, user: user) }
      let(:project) { create(:project, :valid_project) }
      let!(:user_project) { create(:user_project, user: user, project: project, relationship: owner) }

      it 'redirects anon users' do
        post :toggle_folder
        expect(response).to have_http_status(:redirect)
      end

      it 'valid toggle renders nothing' do
        expect {
          post :toggle_folder, params: { folder_id: folder.id, project_ids: [project.id] }, session: { user_id: user.id }
        }.to change(ProjectFolder, :count).by(1)
        expect(response).to render_template(nil)

        expect {
          post :toggle_folder, params: { folder_id: folder.id, project_ids: [project.id] }, session: { user_id: user.id }
        }.to change(ProjectFolder, :count).by(-1)
        expect(response).to render_template(nil)
      end
    end

    describe 'POST #checkall_folder' do

      let(:folder) { create(:folder, :valid_folder, user: user) }
      let(:project) { create(:project, :valid_project) }
      let!(:user_project) { create(:user_project, user: user, project: project, relationship: owner) }

      it 'redirects anon users' do
        post :checkall_folder
        expect(response).to have_http_status(:redirect)
      end

      it 'valid check all renders nothing' do
        expect {
          post :checkall_folder, params: { checkall: 1, folder_id: folder.id, project_ids: [project.id] }, session: { user_id: user.id }
        }.to change(ProjectFolder, :count).by(1)
        expect(response).to render_template(nil)

        expect {
          post :checkall_folder, params: { checkall: 0, folder_id: folder.id, project_ids: [project.id] }, session: { user_id: user.id }
        }.to change(ProjectFolder, :count).by(-1)
        expect(response).to render_template(nil)
      end

    end

    describe 'POST #assigned_folder' do

      it 'redirects anon users' do
        post :assigned_folder
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects when valid' do
        expect {
          post :assigned_folder, params: { assigned: 1 }, session: { user_id: user.id }
        }.to change{ session[:organize_assigned] }
        expect(response).to render_template('folders/_projects_list')
      end
    end

    describe 'GET #organize' do

      it 'redirects anon users' do
        get :organize
        expect(response).to have_http_status(:redirect)
      end

      it 'valid user returns http success' do
        get :organize, params: {}, session: { user_id: user.id }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:organize)
        expect(response).to render_template(:main)
      end
    end

    describe 'GET #index' do

      let(:user2) { create(:user, :valid_user) }
      let!(:project_folder){ create(:project_folder, :valid_project_folder, user: user2) }

      it 'redirects anon users' do
        get :index
        expect(response).to have_http_status(:redirect)
      end

      it 'valid user returns http success' do
        get :index, params: {}, session: { user_id: user.id }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(response).to render_template(:main)
      end

      it 'valid user with organized folders returns http success' do
        get :index, params: {}, session: { user_id: user2.id }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(response).to render_template(:main)
      end
    end

    describe 'GET #new' do

      it 'redirects anon users' do
        get :new
        expect(response).to have_http_status(:redirect)
      end

      it 'valid user returns http success' do
        get :new, params: {}, session: { user_id: user.id }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
        expect(response).to render_template(:main)
      end
    end

    describe 'GET #edit' do

      let(:user2) { create(:user, :valid_user) }
      let(:project) { create(:project, :valid_project) }
      let!(:user_project ) { create(:user_project, user: user, project: project, relationship: owner) }

      it 'redirects anon users' do
        get :edit, params: { id: 0 }
        expect(response).to have_http_status(:redirect)
      end

      it 'valid user returns http success' do
        get :edit, params: { id: project.id }, session: { user_id: user.id }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
        expect(response).to render_template(:main)
      end

      it 'not owner returns http redirect' do
        get :edit, params: { id: project.id }, session: { user_id: user2.id }
        expect(response).to have_http_status(:redirect)
      end

      it 'invalid project id redirects' do
        get :edit, params: { id: 0 }, session: { user_id: user.id }
        expect(response).to have_http_status(:redirect)
      end
    end

    describe 'GET #ask_delete' do

      let(:user2) { create(:user, :valid_user) }
      let(:project) { create(:project, :valid_project) }
      let!(:user_project) { create(:user_project, user: user, project: project, relationship: owner) }

      it 'redirects anon users' do
        get :ask_delete, params: { id: 0 }
        expect(response).to have_http_status(:redirect)
      end

      it 'valid user returns http success' do
        get :ask_delete, params: { id: project.id }, session: { user_id: user.id }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:ask_delete)
        expect(response).to render_template(:main)
      end

      it 'not owner returns http redirect' do
        get :ask_delete, params: { id: project.id }, session: { user_id: user2.id }
        expect(response).to have_http_status(:redirect)
      end

      it 'invalid project id redirects' do
        get :ask_delete, params: { id: 0 }, session: { user_id: user.id }
        expect(response).to have_http_status(:redirect)
      end
    end

    describe 'POST #create' do

      it 'returns form on error' do
        expect {
          post :create, params: { :project => { :name => '' } }, session: { user_id: user.id }
        }.to change(Project, :count).by(0)
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
        expect(response).to render_template(:main)
      end

      it 'redirects when valid' do
        expect {
          post :create, params: { project: { name: 'New Name' } }, session: { user_id: user.id }
        }.to change(Project, :count).by(1)
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects anon user' do
        expect {
          post :create, params: { name: 'New Name' }, session: {}
        }.to change(Project, :count).by(0)
        expect(response).to have_http_status(:redirect)
      end
    end

    describe 'PUT #update' do

      let(:project) { create(:project, :valid_project) }
      let!(:user_project) { create(:user_project, user: user, project: project, relationship: owner) }
      let(:user2) { create(:user, :valid_user) }

      it 'renders form on invalid update' do
        expect {
          put :update, params: { id: project.id, project: { name: '' } }, session: { user_id: user.id }
          project.reload
        }.to_not change{ project.name }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
        expect(response).to render_template(:main)
      end

      it 'redirects on valid update' do
        expect {
          put :update, params: { id: project.id, project: { name: 'Updated Name' } }, session: { user_id: user.id }
          project.reload
        }.to change{ project.name }
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects on invalid project' do
        expect {
          put :update, params: { id: 0, name: 'Updated Name' }, session: { user_id: user.id }
          project.reload
        }.to_not change{ project.name }
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects on invalid project owner' do
        expect {
          put :update, params: { id: project.id, name: 'Updated Name' }, session: { user_id: user2.id }
          project.reload
        }.to_not change{ project.name }
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects on anon user' do
        expect {
          put :update, params: { id: project.id, name: 'Updated Name' }, session: {}
          project.reload
        }.to_not change{ project.name }
        expect(response).to have_http_status(:redirect)
      end
    end

    describe 'DELETE #destroy' do

      let(:project) { create(:project, :valid_project) }
      let!(:user_project) { create(:user_project, user: user, project: project, relationship: owner) }
      let(:user2) { create(:user, :valid_user) }

      it 'redirects on valid project owner' do
        expect {
          delete :destroy, params: { id: project.id }, session: { user_id: user.id }
          project.reload
        }.to change{ project.deleted }
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects on invalid project owner' do
        expect {
          delete :destroy, params: { id: project.id }, session: { user_id: user2.id }
          project.reload
        }.to change(Project, :count).by(0)
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects on anon user' do
        expect {
          delete :destroy, params: { id: project.id }, session: {}
        }.to change(Project, :count).by(0)
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
