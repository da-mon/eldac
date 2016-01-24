
require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

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
        post :create, { name: Faker::Lorem.word.titleize }, { user_id: user.id }
      }.to change(Project, :count).by(1)
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
        put :update, { id: project.id, name: '' }, { user_id: user.id }
        project.reload
      }.to_not change{ project.name }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
      expect(response).to render_template(:main)
    end

    it 'redirects on valid update' do
      expect {
        put :update, { id: project.id, name: Faker::Lorem.word.titleize }, { user_id: user.id }
        project.reload
      }.to change{ project.name }
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects on invalid project' do
      expect {
        put :update, { id: 0, name: Faker::Lorem.word.titleize }, { user_id: user.id }
        project.reload
      }.to_not change{ project.name }
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects on invalid project owner' do
      expect {
        put :update, { id: project.id, name: Faker::Lorem.word.titleize }, { user_id: user2.id }
        project.reload
      }.to_not change{ project.name }
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects on anon user' do
      expect {
        put :update, { id: project.id, name: Faker::Lorem.word.titleize }, {}
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