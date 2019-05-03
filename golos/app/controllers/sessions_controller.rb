class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        @user = user.find_by_parameters(params[:user][:name], params[:user][:password])
        if user 
            log_in!(@user)
        else
            flash.now[:errors] = 'error'
            redirect_to new_session_url
        end
    end

    def destroy
        
    end
end