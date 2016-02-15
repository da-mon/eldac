class Project < ActiveRecord::Base

  has_many :forms, dependent: :destroy
  has_many :project_folders, dependent: :destroy

  has_many :user_projects, :dependent => :destroy
  has_many :users, :through => :user_projects

  validates :name, presence: true, length: {maximum: 64}

end
