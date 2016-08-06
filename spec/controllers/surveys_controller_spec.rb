require 'rails_helper'

RSpec.describe SurveysController, type: :controller do

  describe 'POST #create' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }

    it 'anon redirects' do
      expect {
        post :create, params: { project_id: project.id, survey: { name: 'Survey 1' } }, session: { user_id: nil }
      }.to change(Survey, :count).by(0)
      expect(response).to have_http_status(:redirect)
    end

    it 'valid survey returns redirect' do
      expect {
        post :create, params: { project_id: project.id, survey: { name: 'Survey 1' } }, session: { user_id: user.id }
      }.to change(Survey, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid survey returns errors' do
      expect {
        post :create, params: { project_id: project.id, survey: { name: nil } }, session: { user_id: user.id }
      }.to change(Survey, :count).by(0)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:survey) { create(:survey, project: project) }

    it 'anon user returns redirect' do
      get :edit, params: { project_id: project.id, id: survey.id }, session: { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid project id returns redirect' do
      get :edit, params: { project_id: 0, id: survey.id }, session: { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid survey id returns redirect' do
      get :edit, params: { project_id: project.id, id: 0 }, session: { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'returns http success' do
      get :edit, params: { project_id: project.id, id: survey.id }, session: { user_id: user.id }
      expect(response).to render_template('surveys/edit')
    end
  end

  describe 'POST #update' do

    let(:user) { create(:user, :valid_user) }
    let(:project) { create(:project) }
    let(:relationship) { create(:relationship, :owner) }
    let!(:user_project) { create(:user_project, user: user, project: project, relationship: relationship) }
    let(:survey) { create(:survey, project: project) }

    it 'anon user returns redirect' do
      post :update, params: { project_id: project.id, id: survey.id, survey: { name: 'New' } }, session: { user_id: nil }
      expect(response).to have_http_status(:redirect)
    end

    it 'valid survey returns redirect' do
      post :update, params: { project_id: project.id, id: survey.id, survey: { name: 'New' } }, session: { user_id: user.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'invalid survey returns errors' do
      post :update, params: { project_id: project.id, id: survey.id, survey: { name: nil } }, session: { user_id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
end
