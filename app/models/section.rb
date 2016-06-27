class Section < ActiveRecord::Base

  belongs_to :page
  acts_as_list scope: :page

  has_many :fields, dependent: :destroy

  validates :page_id, presence: true
  validates :name, presence: true, length: {maximum: 64}, uniqueness: {scope: :page_id}

end
