
require 'rails_helper'

RSpec.describe FormsController, type: :controller do

  describe 'POST #save_sort' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }
    let(:form2) { create(:form, project: project, name: 'Form 2') }
    let(:order) { "f[]=#{form.id}&f[]=#{form2.id}" }

    it 'anon user returns redirect' do
      post :save_sort, { project_id: project.id, order: order }, { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid project returns redirect' do
      post :save_sort, { project_id: 0, order: order }, { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'valid project and order sorts' do
      post :save_sort, { project_id: project.id, order: order }, { user_id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

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

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }

    it 'anon user returns redirect' do
      post :update, { project_id: project.id, id: form.id, form: { name: 'New' } }, { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'valid form returns redirect' do
      post :update, { project_id: project.id, id: form.id, form: { name: 'New' } }, { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid form returns errors' do
      post :update, { project_id: project.id, id: form.id, form: { name: nil } }, { user_id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #ask_delete' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }

    it 'anon user returns redirect' do
      xhr :get, :ask_delete, { project_id: project.id, id: form.id }, { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid project id returns redirect' do
      xhr :get, :ask_delete, { project_id: 0, id: form.id }, { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid form id returns redirect' do
      xhr :get, :ask_delete, { project_id: project.id, id: 0 }, { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'returns http success' do
      xhr :get, :ask_delete, { project_id: project.id, id: form.id }, { user_id: user.id }
      expect(response).to render_template('forms/ask_delete')
    end
  end

  describe 'POST #destroy' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let!(:form) { create(:form, project: project) }

    it 'returns redirect' do
      expect {
        delete :destroy, { project_id: project.id, id: form.id, format: :js }, { user_id: user.id }
      }.to change(Form, :count).by(-1)
      expect(response).to render_template('forms/destroy')
    end

    it 'anon user returns redirect' do
      expect {
        delete :destroy, { project_id: project.id, id: form.id, format: :js }, { user_id: nil }
      }.to change(Form, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid form returns redirect' do
      expect {
        delete :destroy, { project_id: project.id, id: 0, format: :js }, { user_id: user.id }
      }.to change(Form, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid form returns redirect' do
      expect {
        delete :destroy, { project_id: 0, id: form.id, format: :js }, { user_id: user.id }
      }.to change(Form, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end
  end

end
