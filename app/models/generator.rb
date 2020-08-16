class Generator < ApplicationRecord
    has_many :documents 
    has_many :users, through: :documents     
end
