class SurveysController < ApplicationController

  before_action :require_login
  before_action :get_project
  before_action :get_survey, only: [:edit, :update, :ask_delete, :destroy]

  layout 'main'

  def create
    @survey = Survey.create(survey_params.merge(project: @project))
    if @survey.valid?
      redirect_to edit_project_survey_path(@project, @survey)
      return
    end
    render 'projects/edit'
  end

  def edit
  end

  def update
    @survey.update(survey_params)
    if @survey.valid?
      redirect_to edit_project_survey_path(@project, @survey)
      return
    end
    render 'surveys/edit'
  end

  def ask_delete
  end

  def destroy
    @id = @survey.id
    @survey.destroy
  end

  private

  def survey_params
    params.require(:survey).permit(:name)
  end

  def get_survey
    @survey = @project.surveys.where(id: params[:id]).first
    redirect_to root_path unless @survey
  end

end
