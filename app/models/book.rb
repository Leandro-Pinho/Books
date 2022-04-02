class Book < ApplicationRecord
  # o Book pertence a um usuario 
  belongs_to :user
end