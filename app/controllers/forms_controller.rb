class FormsController < ApplicationController

  before_filter :require_login

  layout 'main'

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def save_sort
    position = 1
    params[:order].split('&').each do |s|
      id = s.split('=')[1].to_i
      folder = @current_user.folders.where(:id => id).first
      if folder
        folder.position = position
        folder.save!
        position += 1
      end
    end
    render nothing: true
  end

end
