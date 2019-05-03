class UsersController < ApplicationController
    def new
        render :new
    end

    def index
        @users = User.all
        render :index
    end

    def destroy
        user = User.find(params[:id])

        user.delete
        redirect_to new_user_url
    end

    def create
        @user = User.new(user_params)
        if @user.save
            log_in!(@user)
            redirect_to users_url
        else 
            flash.now[:errors] = "invalid username or password"
            redirect_to new_user_url
        end
    end

    private
    def user_params
        params.require(:user).permit(:name, :password)
    end
end