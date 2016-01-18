
require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end

  end

  describe "POST #create" do

    let(:valid) { create(:user, :valid) }

    it "invalid user renders new form" do
      expect {
        post :create, :user => { :fname => '' }
      }.to change(User, :count).by(0)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end

    it "valid user info redirects" do
      expect {
        post :create, :user => attributes_for(:user, email: 'valid2@example.com')
      }.to change(User, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end

  end

end
