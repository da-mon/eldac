class Survey < ActiveRecord::Base

  belongs_to :project, counter_cache: true

  has_many :survey_forms, dependent: :destroy
  has_many :forms, through: :survey_forms
  
end
