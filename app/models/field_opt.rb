class FieldOpt < ActiveRecord::Base

  belongs_to :field, counter_cache: true
  acts_as_list scope: :field

  validates :field_id, presence: true

  validates :name, presence: true, length: { maximum: 64 }, uniqueness: { scope: :field_id }

end
