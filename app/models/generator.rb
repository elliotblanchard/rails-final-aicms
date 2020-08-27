class Generator < ApplicationRecord
    has_many :documents 
    has_many :users, through: :documents    
    
    validates :name, presence: true
    validates :name, uniqueness: true    
    validates :api_url, presence: true
    validates :api_url, format: { with: URI.regexp }
    validates :api_url, uniqueness: true
    validates :description, presence: true        

    def generator_request(params)
        authorization = "Bearer #{ENV['INFERKIT_KEY']}"
        start_from_beginning = params[:start_at_beginning].to_i == 1 ? (true) : (false)
        force_no_end = params[:pause_at_end].to_i == 1 ? (true) : (false)
        is_continuation = params[:is_continuation].to_i == 1 ? (true) : (false)

        response = HTTParty.post(self.api_url, 
        :body => { :prompt => { :text => params[:prompt], :isContinuation => is_continuation }, 
                :length => params[:length].to_i,
                :startFromBeginning => start_from_beginning,
                :streamResponse => false,
                :forceNoEnd => force_no_end,
                :topP => params[:top_p].to_f,
                :temperature => params[:temperature].to_f
                }.to_json,
        :headers => { :authorization => authorization } ) 
        parsed = JSON.parse(response.body)
        parsed["data"]["text"]
        
        #"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    end
end