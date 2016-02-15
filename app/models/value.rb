class Value < ActiveRecord::Base

  belongs_to :record
  belongs_to :field

  validates :record_id, presence: true
  validates :field_id, presence: true

end
