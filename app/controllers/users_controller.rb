class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        if @user.save
            session[:user_id] = @user.id # have a user signed in after they sign up
            redirect_to root_path
        else
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
        # you don't need password_digest because you want to permit password and password_confirmation which will come from the form and they will get hashed and stored in password_digest
    end
end
