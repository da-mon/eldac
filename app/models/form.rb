class Form < ActiveRecord::Base

  belongs_to :project
  acts_as_list scope: :project

  has_many :pages, -> { order :position }, dependent: :destroy
  has_many :records, dependent: :destroy

  validates :project_id, presence: true
  validates :name, presence: true, length: { maximum: 64 }, uniqueness: { scope: :project_id }

end
