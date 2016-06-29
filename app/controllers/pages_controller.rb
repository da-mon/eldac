class PagesController < ApplicationController

  before_filter :require_login
  before_filter :get_form
  before_filter :get_page, only: [:ask_delete, :destroy, :edit, :update]

  layout 'main'

  def create
    @page = Page.create(page_params.merge(form: @form))
    if @page.valid?
      redirect_to edit_project_form_path(@project, @form)
      return
    end
    @pages = @form.pages
    render 'forms/edit'
  end

  def edit
    @sections = @page.sections
    @section = Section.new
  end

  def update
    @page.update(page_params)
    if @page.valid?
      redirect_to edit_form_page_path(@form, @page)
      return
    end
    @sections = @page.sections
    @section = Section.new
    render 'pages/edit'
  end

  def ask_delete
  end

  def destroy
    @id = @page.id
    @page.destroy
  end

  def save_sort
    position = 1
    params[:order].split('&').each do |s|
      id = s.split('=')[1].to_i
      page = @form.pages.where(id: id).first
      if page
        page.position = position
        page.save!
        position += 1
      end
    end
    render nothing: true
  end

  private

  def page_params
    params.require(:page).permit(:name)
  end

  def get_form
    @form = Form.where(id: params[:form_id]).first
    @project = @current_user.projects.where(id: @form.project_id).first if @form
    @form = nil unless @project
    redirect_to root_path unless @form
  end

  def get_page
    @page = @form.pages.where(id: params[:id]).first
    @project = @current_user.projects.where(id: @page.form.project_id).first if @page
    @page = nil unless @project
    redirect_to root_path unless @page
  end

end
