class Folder < ActiveRecord::Base
  include Colorful

  belongs_to :user
  acts_as_list scope: :user

  has_many :project_folders, dependent: :destroy
  has_many :projects, through: :project_folders

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 64 }
  validates :fg, presence: true, length: { is: 6 }
  validates :bg, presence: true, length: { is: 6 }

  def td_style
    'color: #' << fg << ';' << Folder.bg_css(bg, Folder.diff(bg, 0.9))
  end

  def a_style
    'text-decoration: none; color: #' << fg
  end

end
