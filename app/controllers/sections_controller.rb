class SectionsController < ApplicationController

  before_action :require_login
  before_action :get_page
  before_action :get_section, only: [:ask_delete, :destroy, :edit, :update]

  layout 'main'

  def create
    @section = Section.create(section_params.merge(page: @page))
    if @section.valid?
      redirect_to edit_form_page_path(@page.form, @page)
      return
    end
    #@section = @page.sections
    render 'pages/edit'
  end

  def edit
    @fields = @section.fields
    @field = Field.new
    @form = @section.page.form
    @field_types = FieldType.all
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
    params.require(:section).permit(:name)
  end

  def get_page
    @page = Page.where(id: params[:page_id]).first
    @project = @current_user.projects.where(id: @page.form.project_id).first if @page
    @page = nil unless @project
    redirect_to root_path unless @page
  end

  def get_section
    @section = Section.where(id: params[:id]).first
    @project = @current_user.projects.where(id: @section.page.form.project_id).first if @section
    @section = nil unless @project
    redirect_to root_path unless @section
  end

end
