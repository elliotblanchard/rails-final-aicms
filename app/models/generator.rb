class Generator < ApplicationRecord
    has_many :documents 
    has_many :users, through: :documents    
    
    validates :name, presence: true
    validates :api_url, presence: true
    validates :api_url, format: { with: URI.regexp }, if: 'api_url.present?'
    validates :description, presence: true        

    def generator_request(params)
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    end
end