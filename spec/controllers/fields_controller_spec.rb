require 'rails_helper'

RSpec.describe FieldsController, type: :controller do

  describe "POST #create" do
    it "returns http redirect" do
      post :create
      expect(response).to have_http_status(:redirect)
    end
  end

end
