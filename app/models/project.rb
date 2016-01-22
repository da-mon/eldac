class Project < ActiveRecord::Base

  validates :name, presence: true, length: {in: 1..64}

end
