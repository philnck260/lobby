class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content,
  presence: true,
  length: {maximum: 500, message: "Le contenu ne doit pas dépasser 500 caractères"}


end
