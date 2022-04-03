class Book < ApplicationRecord
  # o Book pertence a um usuario 
  belongs_to :user
  # o book tem uma categoria 
  belongs_to :category
  # para mostrar a imagem 
  mount_uploader :picture, PictureUploader
end