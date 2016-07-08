class FieldsController < ApplicationController

  before_action :require_login
  before_action :get_section
  before_action :get_field, only: [:ask_delete, :destroy, :edit, :update]
  
  layout 'main'

  def edit
    @field_types = FieldType.sorted
  end

  def update
    @field.update(field_params)
    if @field.valid?
      redirect_to edit_section_field_path(@section, @field)
      return
    end
    @field_types = FieldType.all
    render 'fields/edit'
  end
  
  def create
    @field = Field.create(field_params.merge(section: @section))
    if @field.valid?
      redirect_to edit_page_section_path(@section.page, @section)
      return
    end
    @field_types = FieldType.all
    render 'sections/edit'
  end

  def ask_delete
  end

  def destroy
    @id = @field.id
    @field.destroy
  end

  def save_sort
    position = 1
    params[:order].split('&').each do |s|
      id = s.split('=')[1].to_i
      field = @section.fields.where(id: id).first
      if field
        field.position = position
        field.save!
        position += 1
      end
    end
    render nothing: true
  end
  
  private

  def field_params
    params.require(:field).permit(:name, :field_type_id)
  end

  def get_section
    @section = Section.where(id: params[:section_id]).first
    @project = @current_user.projects.where(id: @section.page.form.project_id).first if @section
    @section = nil unless @project
    redirect_to root_path unless @section
  end

  def get_field
    @field = Field.where(id: params[:id]).first
    @project = @current_user.projects.where(id: @field.section.page.form.project_id).first if @field
    @field = nil unless @project
    redirect_to root_path unless @field
  end
  
end
