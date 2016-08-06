class Survey < ActiveRecord::Base

  belongs_to :project, counter_cache: true
  acts_as_list scope: :project

  has_many :survey_forms, dependent: :destroy
  has_many :forms, through: :survey_forms

  has_many :records, dependent: :destroy

  validates :project_id, presence: true
  validates :name, presence: true, length: { maximum: 64 }, uniqueness: { scope: :project_id }

end
