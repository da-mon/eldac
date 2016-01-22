class ProjectsController < ApplicationController

  before_filter :require_login

  layout 'main'

  def index
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    if @project.valid?
      @user_project = UserProject.create!(:user => @current_user, :project => @project, :relationship => Relationship.owner)
      redirect_to edit_project_path(@project)
      return false
    end
    render :new
    return false
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def project_params
    params.permit(:name)
  end

end
