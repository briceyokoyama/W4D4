class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :auth_token

    def login!(user) 
        session[:session_token] = user.reset_session_token!
        debugger
    end

    def logout!
        session[:session_token] = nil
        if current_user
            @current_user.reset_session_token!
        end
        @current_user = nil
    end

    def current_user
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!(current_user)
    end

    def auth_token
        "<input type=\"hidden\" name=\"authenticity_token\" value=\"#{form_authenticity_token}\">".html_safe
    end

end
