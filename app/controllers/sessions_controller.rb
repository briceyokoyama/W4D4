class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        # fail
        if @user
            login!(@user)
            # fail
            redirect_to user_url(@user)
        else
            flash.now[:errors] = "Username or Password incorrect."
            render :new
        end
    end

    def destroy
        @user = User.find_by(session_token: session[:session_token])
        logout!
        render :new
    end
    
end