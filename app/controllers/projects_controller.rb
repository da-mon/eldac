class ProjectsController < ApplicationController

  before_action :require_login

  layout 'main'

  def index
    if @current_user.project_folders.count.zero?
      @projects = @current_user.undeleted_projects
    else
      @unfoldered_projects = @current_user.unfoldered_projects
      @folders = @current_user.folders
    end
    @projects_count = @current_user.undeleted_projects.count
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    if @project.valid?
      UserProject.create!(:user => @current_user, :project => @project, :relationship => Relationship.owner)
      redirect_to edit_project_path(@project)
      return
    end
    render :new
    return
  end

  def edit
    @project = project_by_id params[:id]
    unless @project && @current_user.is_owner?(@project)
      flash[:notice] = 'Project not found'
      redirect_to projects_path
      return
    end
    @surveys = @project.surveys
    @survey = Survey.new
    @forms = @project.forms
    @form = Form.new
  end

  def update
    @project = project_by_id params[:id]
    unless @project && @current_user.is_owner?(@project)
      flash[:notice] = 'Project not found'
      redirect_to projects_path
      return
    end
    @project.update(project_params)
    if @project.valid?
      redirect_to edit_project_path
      return
    end
    flash[:notice] = 'Project update failed'
    render :edit
    return
  end

  def ask_delete
    @project = project_by_id params[:id]
    unless @project && @current_user.is_owner?(@project)
      flash[:notice] = 'Project not found'
      redirect_to projects_path
      return
    end
  end

  def destroy
    @project = project_by_id params[:id]
    if @project && @current_user.is_owner?(@project)
      name = @project.name
      @project.deleted = true
      @project.save
      @project.project_folders.destroy_all
      flash[:notice] = "Project #{name} deleted"
    else
      flash[:notice] = 'Project not found'
    end
    redirect_to projects_path
    return
  end

  def organize
    @projects = @current_user.undeleted_projects
    @folders = @current_user.folders
    @folder = Folder.new
  end

  def assigned_folder
    session[:organize_assigned] = params[:assigned].to_i
    get_projects_list
    render :partial => 'folders/projects_list'
    return
  end

  def checkall_folder
    if params[:project_ids]
      @folder = @current_user.folders.where(:id => params[:folder_id].to_i).first
      unless @folder.nil?
        params[:project_ids].collect{ |id| id.to_i }.each do |id|
          @project_folder = @current_user.project_folders.where(:folder => @folder, :project_id => id).first
          if params[:checkall].to_i == 1
            ProjectFolder.create!(:user => @current_user,
                                  :project_id => id,
                                  :folder => @folder) unless @project_folder
          else
            @project_folder.destroy if @project_folder
          end
        end
      end
    end
    head :ok
  end

  def toggle_folder
    @folder = @current_user.folders.where(:id => params[:folder_id].to_i).first
    unless @folder.nil?
      params[:project_ids].collect{|id|id}.each do |id|
        @project_folder = @current_user.project_folders.where(:folder => @folder, :project_id => id).first
        if @project_folder
          @project_folder.destroy
        else
          ProjectFolder.create!(:user => @current_user,
                                :project_id => id,
                                :folder => @folder)
        end
      end
    end
    head :ok
  end

  private

  def project_by_id(id)
    @current_user.undeleted_projects.find{|p|p.id == id.to_i}
  end

  def project_params
    params.require(:project).permit(:name)
  end

end
