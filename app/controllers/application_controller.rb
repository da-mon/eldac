class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login
    if session[:user_id].nil?
      flash[:error] = 'Login required'
      redirect_to login_path
      return
    end
    @current_user = User.where(:id => session[:user_id]).first
  end

  def get_project
    @project = @current_user.projects.where(id: params[:project_id]).first
    redirect_to root_path unless @project
  end

  def get_section(id)
    @section = Section.where(id: id).first
    @project = @current_user.projects.where(id: @section.page.form.project_id).first if @section
    @section = nil unless @project
    redirect_to root_path unless @section
  end

  def save_sorted(query)
    position = 1
    params[:order].split('&').each do |s|
      id = s.split('=')[1].to_i
      obj = query.where(id: id).first
      if obj
        obj.position = position
        obj.save!
        position += 1
      end
    end
  end

  def get_projects_list
    @folder = @current_user.folders.where(:id => session[:organize_folder_id]).first
    @projects = @folder.nil? ? [] : @current_user.projects_in(@folder)
    @projects += @current_user.unfoldered_projects
    if session[:organize_assigned].to_i == 1
      @projects += @current_user.assigned_projects
    end
    @projects.uniq!
    @projects.sort_by!(&:name)
    @project_folders = @current_user.project_folders
  end

end
