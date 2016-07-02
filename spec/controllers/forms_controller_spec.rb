
require 'rails_helper'

RSpec.describe FormsController, type: :controller do

  describe 'POST #create' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }

    it 'anon user returns redirect' do
      expect {
        post :create, { project_id: project.id, form: { name: 'Form 1' } }, { user_id: nil }
      }.to change(Form, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

    it 'valid form returns redirect' do
      expect {
        post :create, { project_id: project.id, form: { name: 'Form 1' } }, { user_id: user.id }
      }.to change(Form, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid form returns errors' do
      expect {
        post :create, { project_id: project.id, form: { name: nil } }, { user_id: user.id }
      }.to change(Form, :count).by(0)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    
    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }

    it 'anon user returns redirect' do
      get :edit, { project_id: project.id, id: form.id }, { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid project id returns redirect' do
      get :edit, { project_id: 0, id: form.id }, { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid form id returns redirect' do
      get :edit, { project_id: project.id, id: 0 }, { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'returns http success' do
      get :edit, { project_id: project.id, id: form.id }, { user_id: user.id }
      expect(response).to render_template('forms/edit')
    end
  end

  describe 'POST #update' do
    it 'returns http success' do

    end
  end

  describe 'POST #destroy' do
    it 'returns http success' do

    end
  end

end
