class Folder < ActiveRecord::Base

  belongs_to :user
  acts_as_list :scope => :user

  has_many :project_folders, dependent: :destroy
  has_many :projects, :through => :project_folders

  validates :user_id, presence: true
  validates :name, presence: true, length: {in: 1..64}
  validates :fg, presence: true, length: {is: 6}
  validates :bg, presence: true, length: {is: 6}

end
