class Category < ApplicationRecord
    # uma categoria tem muitos books 
    has_many :books
end
