
require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe 'POST #save_sort' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }
    let(:page) { create(:page, form: form, name: 'Page 1') }
    let(:page2) { create(:page, form: form, name: 'Page 2') }
    let(:order) { "p[]=#{page.id}&p[]=#{page2.id}" }

    it 'anon user returns redirect' do
      post :save_sort, params: { form_id: form.id, order: order }, session: { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid form returns redirect' do
      post :save_sort, params: { form_id: 0, order: order }, session: { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'valid form and order sorts' do
      post :save_sort, params: { form_id: form.id, order: order }, session: { user_id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
  
  describe 'GET #ask_delete' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }
    let!(:page) { create(:page, form: form) }

    it 'anon user returns redirect' do
      get :ask_delete, xhr: true, params: { form_id: form.id, id: page.id }, session: { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid form id returns redirect' do
      get :ask_delete, xhr: true, params: { form_id: 0, id: page.id }, session: { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid page id returns redirect' do
      get :ask_delete, xhr: true, params: { form_id: form.id, id: 0 }, session: { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'returns http success' do
      get :ask_delete, xhr: true, params: { form_id: form.id, id: page.id }, session: { user_id: user.id }
      expect(response).to render_template('pages/ask_delete')
    end
  end
  
  describe 'POST #destroy' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }
    let!(:page) { create(:page, form: form) }

    it 'returns redirect' do
      expect {
        delete :destroy, params: { form_id: form.id, id: page.id, format: :js }, session: { user_id: user.id }
      }.to change(Page, :count).by(-1)
      expect(response).to render_template('pages/destroy')
    end

    it 'anon user returns redirect' do
      expect {
        delete :destroy, params: { form_id: form.id, id: page.id, format: :js }, session: { user_id: nil }
      }.to change(Page, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid page returns redirect' do
      expect {
        delete :destroy, params: { form_id: form.id, id: 0, format: :js }, session: { user_id: user.id }
      }.to change(Page, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid page returns redirect' do
      expect {
        delete :destroy, params: { form_id: 0, id: page.id, format: :js }, session: { user_id: user.id }
      }.to change(Page, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end
  end
  
  describe 'POST #update' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }
    let(:page) { create(:page, form: form) }

    it 'anon user returns redirect' do
      post :update, params: { form_id: form.id, id: page.id, page: { name: 'New' } }, session: { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'valid page returns redirect' do
      post :update, params: { form_id: form.id, id: page.id, page: { name: 'New' } }, session: { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid page returns errors' do
      post :update, params: { form_id: form.id, id: page.id, page: { name: nil } }, session: { user_id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
  
  describe 'GET #edit' do
    
    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }
    let(:page) { create(:page, form: form) }

    it 'anon user returns redirect' do
      get :edit, params: { form_id: form.id, id: page.id }, session: { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid form id returns redirect' do
      get :edit, params: { form_id: 0, id: page.id }, session: { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid page id returns redirect' do
      get :edit, params: { form_id: form.id, id: 0 }, session: { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'returns http success' do
      get :edit, params: { form_id: form.id, id: page.id }, session: { user_id: user.id }
      expect(response).to render_template('pages/edit')
    end
  end
  
  describe 'POST #create' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }
    
    it 'anon user returns redirect' do
      expect {
        post :create, params: { form_id: form.id, page: { name: 'Page 1' } }, session: { user_id: nil }
      }.to change(Page, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

    it 'valid page returns redirect' do
      expect {
        post :create, params: { form_id: form.id, page: { name: 'Page 1' } }, session: { user_id: user.id }
      }.to change(Page, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid page returns errors' do
      expect {
        post :create, params: { form_id: form.id, page: { name: nil } }, session: { user_id: user.id }
      }.to change(Page, :count).by(0)
      expect(response).to have_http_status(:success)
    end
  end

end
