class ApplicationController < ActionController::Base
    private # best practice if this application is being inherited to other controllers

    def current_user
        if session[:user_id].present?
            @current_user ||= User.find_by(id: session[:user_id])
            # .find_by will throw nil where as .find will return an error if it doesn't find the matching id in the session and in db
        end
    end
    helper_method(:current_user)
    # 'helper_method' makes a controller method available to all views or templates

    def user_signed_in?
        current_user.present?
    end
    helper_method(:user_signed_in?)

    def authenticate_user!
        unless user_signed_in?
            flash[:danger] = "you must sign in or sign up first!"
            redirect_to new_session_path
        end
    end
    # helper_method(:authenticate_user!) 
    # don't pass a helper method because we will exclusively pass it in the controller
end
