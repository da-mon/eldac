class FieldsController < ApplicationController

  before_action :require_login
  before_action { get_section( params[:section_id] ) }
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
    save_sorted(@section.fields)
    head :ok
  end
  
  private

  def field_params
    params.require(:field).permit(:name, :field_type_id)
  end

  def get_field
    @field = Field.where(id: params[:id]).first
    @project = @current_user.projects.where(id: @field.section.page.form.project_id).first if @field
    @field = nil unless @project
    redirect_to root_path unless @field
  end
  
end
