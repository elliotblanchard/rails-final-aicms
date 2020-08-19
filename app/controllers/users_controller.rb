class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user
        else
            render :new
        end
    end

    def show
        unless (params[:id].to_i == current_user.id) || admin?
            redirect_to root_path 
        end
        @user = User.find_by_id(params[:id])
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :admin)
    end
end
