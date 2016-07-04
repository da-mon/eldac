require 'rails_helper'

RSpec.describe SectionsController, type: :controller do

  describe 'POST #save_sort' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }
    let(:page) { create(:page, form: form) }
    let(:section) { create(:section, page: page, name: 'Section 1') }
    let(:section2) { create(:section, page: page, name: 'Section 2') }
    let(:order) { "s[]=#{section.id}&s[]=#{section2.id}" }

    it 'anon user returns redirect' do
      post :save_sort, { page_id: page.id, order: order }, { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid page returns redirect' do
      post :save_sort, { page_id: 0, order: order }, { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'valid page and order sorts' do
      post :save_sort, { page_id: page.id, order: order }, { user_id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
  
  describe 'GET #ask_delete' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }
    let(:page) { create(:page, form: form) }
    let(:section) { create(:section, page: page) }

    it 'anon user returns redirect' do
      xhr :get, :ask_delete, { page_id: page.id, id: section.id }, { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid page id returns redirect' do
      xhr :get, :ask_delete, { page_id: 0, id: section.id }, { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid section id returns redirect' do
      xhr :get, :ask_delete, { page_id: page.id, id: 0 }, { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'returns http success' do
      xhr :get, :ask_delete, { page_id: page.id, id: section.id }, { user_id: user.id }
      expect(response).to render_template('sections/ask_delete')
    end
  end
  
  describe 'POST #destroy' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }
    let(:page) { create(:page, form: form) }
    let!(:section) { create(:section, page: page) }

    it 'returns redirect' do
      expect {
        delete :destroy, { page_id: page.id, id: section.id, format: :js }, { user_id: user.id }
      }.to change(Section, :count).by(-1)
      expect(response).to render_template('sections/destroy')
    end

    it 'anon user returns redirect' do
      expect {
        delete :destroy, { page_id: page.id, id: section.id, format: :js }, { user_id: nil }
      }.to change(Section, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid section returns redirect' do
      expect {
        delete :destroy, { page_id: page.id, id: 0, format: :js }, { user_id: user.id }
      }.to change(Section, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid section returns redirect' do
      expect {
        delete :destroy, { page_id: 0, id: section.id, format: :js }, { user_id: user.id }
      }.to change(Section, :count).by(0)
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
    let(:section) { create(:section, page: page) }

    it 'anon user returns redirect' do
      post :update, { page_id: page.id, id: section.id, section: { name: 'New' } }, { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'valid section returns redirect' do
      post :update, { page_id: page.id, id: section.id, section: { name: 'New' } }, { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid section returns errors' do
      post :update, { page_id: page.id, id: section.id, section: { name: nil } }, { user_id: user.id }
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
    let(:section) { create(:section, page: page) }

    it 'anon user returns redirect' do
      get :edit, { page_id: page.id, id: section.id }, { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid page id returns redirect' do
      get :edit, { page_id: 0, id: section.id }, { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid section id returns redirect' do
      get :edit, { page_id: page.id, id: 0 }, { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'returns http success' do
      get :edit, { page_id: page.id, id: section.id }, { user_id: user.id }
      expect(response).to render_template('sections/edit')
    end
  end
  
  describe 'POST #create' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }
    let(:page) { create(:page, form: form) }
    
    it 'anon user returns redirect' do
      expect {
        post :create, { page_id: page.id, section: { name: 'Section 1' } }, { user_id: nil }
      }.to change(Section, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

    it 'valid section returns redirect' do
      expect {
        post :create, { page_id: page.id, section: { name: 'Section 1' } }, { user_id: user.id }
      }.to change(Section, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid section returns errors' do
      expect {
        post :create, { page_id: page.id, section: { name: nil } }, { user_id: user.id }
      }.to change(Section, :count).by(0)
      expect(response).to have_http_status(:success)
    end
  end

end
