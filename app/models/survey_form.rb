class SurveyForm < ActiveRecord::Base

  belongs_to :survey
  belongs_to :form

  validates :survey_id, presence: true
  validates :form_id, presence: true

end
