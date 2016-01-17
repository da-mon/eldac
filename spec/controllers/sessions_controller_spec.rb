
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

  end

  describe "POST #create" do

    let(:valid) { create(:user, :valid) }
    let(:invalid) { create(:user, email_valid: false) }

    it "returns http redirect for a valid user" do
      post :create, email: valid.email, password: valid.password
      expect(response).to have_http_status(:redirect)
      expect(controller.session[:user_id]).to eq(valid.id)
    end

    it "returns http success for an anon user" do
      post :create
      expect(response).to have_http_status(:success)
      expect(controller.session[:user_id]).to eq(nil)
      expect(response).to render_template(:new)
    end

    it "returns http success for an invalid user" do
      post :create, email: invalid.email, password: invalid.password
      expect(response).to have_http_status(:success)
      expect(controller.session[:user_id]).to eq(nil)
      expect(response).to render_template(:new)
    end

  end

  describe "DELETE #destroy" do

    it "returns http success" do
      delete :destroy
      expect(response).to have_http_status(:redirect)
    end

  end

end
