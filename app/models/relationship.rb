class Relationship < ActiveRecord::Base

  validates :name, presence: true, length: { maximum: 64 }, uniqueness: true

  def self.owner
    Relationship.where(name: 'owner').first
  end

end
