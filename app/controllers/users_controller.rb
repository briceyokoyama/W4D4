class UsersController < ApplicationController

    def new
        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            login!(@user)
            render :show
        else
            #render log-in page with errors
             flash.now[:errors] = @user.errors.full_messages
             render :new
        end
    end

    def show
       @user = User.find(params[:id]) 
    end

    private
    def user_params
        params.require(:user).permit(:email, :password, :session_token)
    end
end
