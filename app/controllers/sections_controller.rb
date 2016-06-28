class SectionsController < ApplicationController

  before_filter :require_login
  before_filter :get_page
  before_filter :get_section, only: [:ask_delete, :destroy, :edit, :update]

  layout 'main'

  def create
    @section = Section.create(section_params.merge(page: @page))
    if @section.valid?
      redirect_to edit_form_page_path(@page.form, @page)
      return
    end
    @section = @page.sections
    render 'pages/edit'
  end

  def edit
    @fields = @section.fields
    @field = Field.new
    @form = @section.page.form
  end

  def update
    @section.update(section_params)
    if @section.valid?
      redirect_to edit_page_section_path(@page, @section)
      return
    end
    @fields = @section.fields
    @field = Field.new
    @form = @section.page.form
    render 'sections/edit'
  end
  
  def ask_delete
  end

  def destroy
    @id = @section.id
    @section.destroy
  end

  def save_sort
    position = 1
    params[:order].split('&').each do |s|
      id = s.split('=')[1].to_i
      section = @page.sections.where(id: id).first
      if section
        section.position = position
        section.save!
        position += 1
      end
    end
    render nothing: true
  end

  private

  def section_params
    params.permit(:name)
  end

  def get_page
    @page = Page.where(id: params[:page_id]).first
    @project = @current_user.projects.where(id: @page.form.project_id).first if @page
    @page = nil unless @project
    if @page.nil?
      respond_to do |format|
        format.json{render json: {status: 404, response: 'Page Not Found'}}
        format.html{redirect_to form_pages_path(@form)}
      end
    end
  end

  def get_section
    @section = Section.where(id: params[:id]).first
    @project = @current_user.projects.where(id: @section.page.form.project_id).first if @section
    @section = nil unless @project
    if @section.nil?
      respond_to do |format|
        format.json{render json: {status: 404, response: 'Section Not Found'}}
        format.html{redirect_to @project ? edit_project_path(@project) : projects_path}
      end
    end
  end

end
