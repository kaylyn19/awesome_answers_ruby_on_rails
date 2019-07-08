class SessionsController < ApplicationController
    # we don't change anything in the db
    # so we don't need a model or db

    def new
        # don't need any instance because we are not touching the db
    end

    def create
        user = User.find_by_email params[:email]
        if user&.authenticate(params[:password])
            # The 'session' is an object useable in controllers that uses cookies to store encrypted data.
            # To sign in a user, we store their "user_id" in the session for later retrieval
            session[:user_id] = user.id
            redirect_to root_path, notice: "signed in!"
        else
            flash[:alert] = "wrong email or password!"
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "logged out!"
    end
end
