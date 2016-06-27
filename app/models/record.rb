class Record < ActiveRecord::Base

  belongs_to :user
  belongs_to :form

  has_many :values, dependent: :destroy

  validates :user_id, presence: true
  validates :form_id, presence: true

end
