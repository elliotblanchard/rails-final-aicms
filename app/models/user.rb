class User < ApplicationRecord
    has_secure_password

    has_many :documents 
    has_many :generators, through: :documents     
end
