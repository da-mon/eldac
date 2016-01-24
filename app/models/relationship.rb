class Relationship < ActiveRecord::Base

  validates :name, presence: true, length: {in: 1..64}, uniqueness: true

  def self.owner
    Relationship.where(:name => 'owner').first
  end

end
