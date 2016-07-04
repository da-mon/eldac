class Field < ActiveRecord::Base

  belongs_to :field_type, counter_cache: true
  belongs_to :section, counter_cache: true
  acts_as_list scope: :section

  has_many :field_opts, -> { order :position }, dependent: :destroy

  validates :field_type_id, presence: true, numericality: { only_integer: true }
  validates :section_id, presence: true
  validates :name, presence: true, length: { maximum: 64 }, uniqueness: { scope: :section_id }

  validate :validate_field_type

  private

  def validate_field_type
    errors.add(:field_type_id, 'is invalid') unless FieldType.exists?(self.field_type_id)
  end
  
end
