
require 'rails_helper'

RSpec.describe FoldersController, type: :controller do

  describe "POST #toggle_collapse" do

    let(:user) { create(:user, :valid_user) }
    let(:folder) { create(:folder, :valid_folder, user: user, collapsed: false) }

    it 'valid folder toggles' do
      post :toggle_collapse, params: { id: folder.id }, session: { user_id: user.id }
      folder.reload
      expect(response).to render_template(nil)
      expect(folder.collapsed).to be true
      post :toggle_collapse, params: { id: folder.id }, session: { user_id: user.id }
      folder.reload
      expect(response).to render_template(nil)
      expect(folder.collapsed).to be false
    end

    it 'redirects anon' do
      post :toggle_collapse, params: { id: folder.id }, session: {}
      expect(response).to have_http_status(:redirect)
    end

  end

  describe "POST #save_sort" do

    let(:user) { create(:user, :valid_user) }
    let(:f1) { create(:folder, :valid_folder, user: user) }
    let(:f2) { create(:folder, :valid_folder, user: user) }

    it 'saves sorted folders' do
      order = "f[]=#{f2.id}&f[]=#{f1.id}"
      post :save_sort, params: { order: order }, session: { user_id: user.id }
      expect(response).to render_template(nil)
      expect(f1.position).to eq(2)
      expect(f2.position).to eq(1)
    end

    it 'redirects anon' do
      post :save_sort, params: { order: '' }, session: {}
      expect(response).to have_http_status(:redirect)
    end

  end

  describe "POST #organize" do

    let!(:user) { create(:user, :valid_user) }
    let!(:folder) { create(:folder, :valid_folder, user: user) }

    it "renders projects when no folder" do
      expect {
        post :organize, params: { folder_id: 0 }, session: { user_id: user.id }
      }.to change{ session[:organize_folder_id] }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(nil)
    end

    it "renders projects when valid folder" do
      expect {
        post :organize, params: { folder_id: folder.id }, session: { user_id: user.id }
      }.to change{ session[:organize_folder_id] }
      expect(response).to have_http_status(:success)
      expect(response).to render_template('folders/_projects_list')
    end

    it 'redirects anon' do
      post :organize, params: { folder_id: folder.id }, session: {}
      expect(response).to have_http_status(:redirect)
    end

  end

  describe "DELETE #destroy" do

    let!(:user) { create(:user, :valid_user) }
    let!(:user2) { create(:user, :valid_user) }
    let!(:folder) { create(:folder, :valid_folder, user: user) }
    let!(:folder2) { create(:folder, :valid_folder, user: user2) }

    it 'can delete an owned folder' do
      expect {
        delete :destroy, params: { id: folder.id, format: :js }, session: { user_id: user.id }
      }.to change(Folder, :count).by(-1)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:destroy)
    end

    it 'cannot delete invalid folder' do
      expect {
        delete :destroy, params: { id: 0, format: :js }, session: { user_id: user.id }
      }.to change(Folder, :count).by(0)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:destroy)
    end

    it 'cannot delete unowned folder' do
      expect {
        delete :destroy, params: { id: folder2.id, format: :js }, session: { user_id: user.id }
      }.to change(Folder, :count).by(0)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:destroy)
    end

    it 'redirects anon' do
      expect {
        delete :destroy, params: { id: folder.id, format: :js }, session: {}
      }.to change(Folder, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

  end

  describe "POST #create" do

    let(:user) { create(:user, :valid_user) }

    it "invalid folder renders form" do
      expect {
        post :create, params: { name: '' }, session: { user_id: user.id }
      }.to change(Folder, :count).by(0)
      expect(response).to have_http_status(:success)
      expect(response).to render_template('projects/organize')
      expect(response).to render_template(:main)
    end

    it "valid folder redirects" do
      expect {
        post :create, params: { name: 'New Name' }, session: { user_id: user.id }
      }.to change(Folder, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects anon user' do
      expect {
        post :create, params: { name: 'New Name' }, session: {}
      }.to change(Folder, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

  end

  describe 'GET #edit' do

    let!(:user) { create(:user, :valid_user) }
    let!(:user2) { create(:user, :valid_user) }
    let!(:folder) { create(:folder, :valid_folder, user: user) }
    let!(:folder2) { create(:folder, :valid_folder, user: user2) }

    it 'can edit a folder' do
      expect {
        get :edit, xhr: true, params: { id: folder.id }, session: { user_id: user.id }
      }.to change(Folder, :count).by(0)
      expect(response).to have_http_status(:success)
      expect(response).to render_template('folders/edit')
      expect(assigns(:folder)).to be_valid
    end

    it 'cannot edit an unowned folder' do
      expect {
        get :edit, xhr: true, params: { id: folder2.id }, session: { user_id: user.id }
      }.to change(Folder, :count).by(0)
      expect(response).to have_http_status(:success)
      expect(response).to render_template('folders/edit')
      expect(assigns(:folder)).to be_nil
    end

    it 'cannot edit an invalid folder' do
      expect {
        get :edit, xhr: true, params: { id: 0 }, session: { user_id: user.id }
      }.to change(Folder, :count).by(0)
      expect(response).to have_http_status(:success)
      expect(response).to render_template('folders/edit')
      expect(assigns(:folder)).to be_nil
    end

  end

  describe 'POST #update' do

    let!(:user) { create(:user, :valid_user) }
    let!(:user2) { create(:user, :valid_user) }
    let!(:folder) { create(:folder, :valid_folder, user: user) }
    let!(:folder2) { create(:folder, :valid_folder, user: user2) }

    it 'can update a folder' do
      expect {
        post :update, xhr: true, params: { id: folder.id, name: 'Updated' }, session: { user_id: user.id }
      }.to change(Folder, :count).by(0)
      expect(response).to have_http_status(:success)
      expect(response).to render_template('folders/update')
      expect(assigns(:folder)).to be_valid
    end

    it 'cannot update an unowned folder' do
      expect {
        post :update, xhr: true, params: { id: folder2.id }, session: { user_id: user.id }
      }.to change(Folder, :count).by(0)
      expect(response).to have_http_status(:success)
      expect(response).to render_template('folders/update')
      expect(assigns(:folder)).to be_nil
    end

    it 'cannot update an invalid folder' do
      expect {
        post :update, xhr: true, params: { id: 0 }, session: { user_id: user.id }
      }.to change(Folder, :count).by(0)
      expect(response).to have_http_status(:success)
      expect(response).to render_template('folders/update')
      expect(assigns(:folder)).to be_nil
    end

  end

  describe 'GET #ask_delete' do

    let!(:user) { create(:user, :valid_user) }
    let!(:user2) { create(:user, :valid_user) }
    let!(:folder) { create(:folder, :valid_folder, user: user) }
    let!(:folder2) { create(:folder, :valid_folder, user: user2) }

    it 'can ask_delete a folder' do
      expect {
        get :ask_delete, xhr: true, params: { id: folder.id }, session: { user_id: user.id }
      }.to change(Folder, :count).by(0)
      expect(response).to have_http_status(:success)
      expect(response).to render_template('folders/ask_delete')
      expect(assigns(:folder)).to be_valid
    end

    it 'cannot ask_delete an unowned folder' do
      expect {
        get :ask_delete, xhr: true, params: { id: folder2.id }, session: { user_id: user.id }
      }.to change(Folder, :count).by(0)
      expect(response).to have_http_status(:success)
      expect(response).to render_template('folders/ask_delete')
      expect(assigns(:folder)).to be_nil
    end

    it 'cannot ask_delete an invalid folder' do
      expect {
        get :ask_delete, xhr: true, params: { id: 0 }, session: { user_id: user.id }
      }.to change(Folder, :count).by(0)
      expect(response).to have_http_status(:success)
      expect(response).to render_template('folders/ask_delete')
      expect(assigns(:folder)).to be_nil
    end

  end

end
