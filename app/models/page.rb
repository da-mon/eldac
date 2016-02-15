class Page < ActiveRecord::Base

  belongs_to :form
  acts_as_list scope: :form

  has_many :sections, dependent: :destroy

  validates :form_id, presence: true
  validates :name, presence: true, length: {maximum: 64}, uniqueness: {scope: :form_id}

end
