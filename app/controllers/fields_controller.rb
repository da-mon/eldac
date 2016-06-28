class FieldsController < ApplicationController

  before_filter :require_login
  before_filter :get_section
  before_filter :get_field, only: [:ask_delete, :destroy, :edit, :update]
  
  layout 'main'

  def create
    @field = Field.create(field_params.merge(section: @section))
    if @field.valid?
      redirect_to edit_page_section_path(@page, @section)
      return
    end
    @section = @field.section
    render 'sections/edit'
  end

  private

  def field_params
    params.permit(:name)
  end

  def get_section
    @section = Section.where(id: params[:section_id]).first
    @project = @current_user.projects.where(id: @section.page.form.project_id).first if @section
    @section = nil unless @project
    if @section.nil?
      respond_to do |format|
        format.json{render json: {status: 404, response: 'Section Not Found'}}
        format.html{redirect_to root_path}
      end
    end
  end

  def get_field
    @field = Field.where(id: params[:id]).first
    @project = @current_user.projects.where(id: @field.section.page.form.project_id).first if @field
    @field = nil unless @project
    if @field.nil?
      respond_to do |format|
        format.json{render json: {status: 404, response: 'Field Not Found'}}
        format.html{redirect_to root_path}
      end
    end
  end
  
end
