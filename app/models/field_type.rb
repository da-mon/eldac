class FieldType < ActiveRecord::Base

  has_many :fields, dependent: :destroy

end
