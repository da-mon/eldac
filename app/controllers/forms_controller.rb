class FormsController < ApplicationController

  before_filter :require_login
  before_filter :get_project
  before_filter :get_form, only: [:edit, :update, :ask_delete, :destroy]

  layout 'main'

  def create
    @form = Form.create(form_params.merge(project: @project))
    if @form.valid?
      redirect_to edit_project_path(@project)
      return
    end
    @forms = @project.forms
    render 'projects/edit'
  end

  def edit
    @pages = @form.pages
    @page = Page.new
  end

  def update
    @form.update(form_params)
    if @form.valid?
      redirect_to edit_project_form_path(@project, @form)
      return
    end
    @pages = @form.pages
    @page = Page.new
    render 'forms/edit'
  end

  def ask_delete
  end

  def destroy
    @id = @form.id
    @form.destroy
  end

  def save_sort
    position = 1
    params[:order].split('&').each do |s|
      id = s.split('=')[1].to_i
      form = @project.forms.where(:id => id).first
      if form
        form.position = position
        form.save!
        position += 1
      end
    end
    render nothing: true
  end

  private

  def form_params
    params.permit(:name)
  end

  def get_form
    @form = @project.forms.where(id: params[:id]).first
    if @form.nil?
      respond_to do |format|
        format.json{render json: {status: 404, response: 'Form Not Found'}}
        format.html{redirect_to @project ? edit_project_path(@project) : projects_path}
      end
    end
  end

  def get_project
    @project = @current_user.projects.where(id: params[:project_id]).first
    if @project.nil?
      respond_to do |format|
        format.json{render json: {status: 404, response: 'Project Not Found'}}
        format.html{redirect_to projects_path}
      end
    end
  end

end
