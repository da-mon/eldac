class FoldersController < ApplicationController

  before_action :require_login

  layout 'main'

  def update
    @folder = @current_user.folders.where( id: params[:id] ).first
    @folder.update(folder_params) if @folder
  end

  def ask_delete
    @folder = @current_user.folders.where( id: params[:id] ).first
  end

  def edit
    @folder = @current_user.folders.where( id: params[:id] ).first
  end

  def toggle_collapse
    @folder = @current_user.folders.where(:id => params[:id]).first
    @folder.collapsed = !@folder.collapsed
    @folder.save!
    head :ok
  end

  def save_sort
    save_sorted(@current_user.folders)
    head :ok
  end

  def organize
    session[:organize_folder_id] = params[:folder_id].to_i
    get_projects_list
    if @folder
      render :partial => 'projects_list'
      return
    end
    head :ok
  end

  def destroy
    @folder = @current_user.folders.where(id: params[:id]).first
    if @folder
      @id = @folder.id
      @folder.destroy
    end
  end

  def create
    @folder = Folder.create(folder_params)
    if @folder.valid?
      session[:show] = 'edit_folder'
      session[:id] = @folder.id
      redirect_to organize_projects_path
      return
    end
    @projects = @current_user.undeleted_projects
    @folders = @current_user.folders
    render 'projects/organize'
  end

  private

  def folder_params
    params.permit(:id, :name, :fg, :bg).merge(:user => @current_user)
  end

end
