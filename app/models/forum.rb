class Forum < ApplicationRecord
  belongs_to :commitment, 
  optional: true 
  
  has_many :posts
end
