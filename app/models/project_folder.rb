class ProjectFolder < ActiveRecord::Base

  belongs_to :user
  belongs_to :project
  belongs_to :folder

  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :folder_id, presence: true, uniqueness: { scope: [:user_id, :project_id] }

  def self.should_be_checked(project_folders, folder_id, project)
    project_folders.each do |pf|
      return true if (pf.folder_id == folder_id && pf.project == project)
    end
    false
  end

end
