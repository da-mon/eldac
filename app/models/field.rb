class Field < ActiveRecord::Base

  belongs_to :field_type
  belongs_to :section
  acts_as_list scope: :section

  has_many :field_opts, dependent: :destroy

  validates :field_type_id, presence: true
  validates :section_id, presence: true
  validates :name, presence: true, length: {maximum: 64}, uniqueness: {scope: :section_id}

end
