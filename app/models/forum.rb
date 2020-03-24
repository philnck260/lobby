class Forum < ApplicationRecord
  belongs_to :commitment
  has_many :posts
end
