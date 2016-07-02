class FieldType < ActiveRecord::Base

  has_many :fields, dependent: :destroy

  validates :name, presence: true, length: { maximum: 32 }, uniqueness: true

  def to_s
    name
  end
  
end
