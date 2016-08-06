class Record < ActiveRecord::Base

  belongs_to :user
  belongs_to :form, counter_cache: true
  belongs_to :survey, counter_cache: true

  has_many :values, dependent: :destroy

  validates :user_id, presence: true
  validates :form_id, presence: true

end
