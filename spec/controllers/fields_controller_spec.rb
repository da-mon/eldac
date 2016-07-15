require 'rails_helper'

RSpec.describe FieldsController, type: :controller do

  describe 'POST #save_sort' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }
    let(:page) { create(:page, form: form) }
    let(:section) { create(:section, page: page) }
    let(:field_type) { create(:field_type) }
    let(:field) { create(:field, section: section, field_type: field_type, name: 'Field 1') }
    let(:field2) { create(:field, section: section, field_type: field_type, name: 'Field 2') }
    let(:order) { "f[]=#{field.id}&f[]=#{field2.id}" }

    it 'anon user returns redirect' do
      post :save_sort, params: { section_id: section.id, order: order }, session: { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid section returns redirect' do
      post :save_sort, params: { section_id: 0, order: order }, session: { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'valid section and order sorts' do
      post :save_sort, params: { section_id: section.id, order: order }, session: { user_id: user.id }
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
    let(:field_type) { create(:field_type) }
    let(:field) { create(:field, section: section, field_type: field_type) }

    it 'anon user returns redirect' do
      get :ask_delete, xhr: true, params: { section_id: section.id, id: field.id }, session: { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid section id returns redirect' do
      get :ask_delete, xhr: true, params: { section_id: 0, id: field.id }, session: { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid field id returns redirect' do
      get :ask_delete, xhr: true, params: { section_id: section.id, id: 0 }, session: { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'returns http success' do
      get :ask_delete, xhr: true, params: { section_id: section.id, id: field.id }, session: { user_id: user.id }
      expect(response).to render_template('fields/ask_delete')
    end
  end
  
  describe 'POST #destroy' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }
    let(:page) { create(:page, form: form) }
    let(:section) { create(:section, page: page) }
    let(:field_type) { create(:field_type) }
    let!(:field) { create(:field, section: section, field_type: field_type) }

    it 'returns redirect' do
      expect {
        delete :destroy, params: { section_id: section.id, id: field.id, format: :js }, session: { user_id: user.id }
      }.to change(Field, :count).by(-1)
      expect(response).to render_template('fields/destroy')
    end

    it 'anon user returns redirect' do
      expect {
        delete :destroy, params: { section_id: section.id, id: field.id, format: :js }, session: { user_id: nil }
      }.to change(Field, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid field returns redirect' do
      expect {
        delete :destroy, params: { section_id: section.id, id: 0, format: :js }, session: { user_id: user.id }
      }.to change(Field, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid field returns redirect' do
      expect {
        delete :destroy, params: { section_id: 0, id: field.id, format: :js }, session: { user_id: user.id }
      }.to change(Field, :count).by(0)
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
    let(:field_type) { create(:field_type) }
    let(:field) { create(:field, section: section, field_type: field_type) }

    it 'anon user returns redirect' do
      post :update, params: { section_id: section.id, id: field.id, field: { name: 'New' } }, session: { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'valid field returns redirect' do
      post :update, params: { section_id: section.id, id: field.id, field: { name: 'New' } }, session: { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid name returns errors' do
      post :update, params: { section_id: section.id, id: field.id, field: { name: nil, field_type_id: field_type.id } }, session: { user_id: user.id }
      expect(response).to have_http_status(:success)
    end

    it 'invalid field type returns errors' do
      post :update, params: { section_id: section.id, id: field.id, field: { name: 'New', field_type_id: 0 } }, session: { user_id: user.id }
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
    let(:field_type) { create(:field_type) }
    let(:field) { create(:field, section: section, field_type: field_type) }

    it 'anon user returns redirect' do
      get :edit, params: { section_id: section.id, id: field.id }, session: { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid section id returns redirect' do
      get :edit, params: { section_id: 0, id: field.id }, session: { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid field id returns redirect' do
      get :edit, params: { section_id: section.id, id: 0 }, session: { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'returns http success' do
      get :edit, params: { section_id: section.id, id: field.id }, session: { user_id: user.id }
      expect(response).to render_template('fields/edit')
    end
  end

  describe 'POST #create' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:form) { create(:form, project: project) }
    let(:page) { create(:page, form: form) }
    let(:section) { create(:section, page: page) }
    let(:field_type) { create(:field_type) }
    
    it 'anon user returns redirect' do
      expect {
        post :create, params: { section_id: section.id, field: { name: 'Field 1', field_type_id: field_type.id } }, session: { user_id: nil }
      }.to change(Field, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

    it 'valid field returns redirect' do
      expect {
        post :create, params: { section_id: section.id, field: { name: 'Field 1', field_type_id: field_type.id } }, session: { user_id: user.id }
      }.to change(Field, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid name returns errors' do
      expect {
        post :create, params: { section_id: section.id, field: { name: nil, field_type_id: field_type.id } }, session: { user_id: user.id }
      }.to change(Field, :count).by(0)
      expect(response).to have_http_status(:success)
    end

    it 'invalid field type returns errors' do
      expect {
        post :create, params: { section_id: section.id, field: { name: 'Field 1', field_type_id: 0 } }, session: { user_id: user.id }
      }.to change(Field, :count).by(0)
      expect(response).to have_http_status(:success)
    end
  end

end
