class Post < ApplicationRecord
  
  validates :title, 
  presence: {message: ': Un titre de post est requis'},
  length: {minimum: 5, maximum: 50, message: ': Le titre doit contenir un minimum de 5 et un maximum de 50 caractères'}

  validates :content,
  presence: {message: ': Un contenu de post est requis'},
  length: {minimum: 5, maximum: 500}

  belongs_to :user
  has_many :replies
  
end

