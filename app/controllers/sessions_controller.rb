require 'pry'

class SessionsController < ApplicationController

    def index
        
    end    

    def destroy
        session.clear
        redirect_to root_path
    end

    def new

    end

    def create
        user = User.find_by(username: params[:user][:username])
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            redirect_to user_path(user)
        else
            flash[:message] = "Incorrect login info, please try again."
            redirect_to login_path
        end 
    end 
    
    def googleauth
        @user = User.find_or_create_by(username: auth["extra"]["id_info"]["sub"]) do |user|
            user.username = auth["info"]["first_name"]
            user.password = SecureRandom.hex(10)
        end
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            redirect_to '/'
        end
    end

    private

    def auth
        request.env['omniauth.auth']
    end
end