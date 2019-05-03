class UsersController < ApplicationController
    def new
        render :new
    end

    def index
        render :index
    end

    def destroy
        user = User.find(params[:id])

        user.delete
        redirect_to new_user_url
    end

    private
    def user_params
        params.require(:user).permit(:name, :password)
    end
end