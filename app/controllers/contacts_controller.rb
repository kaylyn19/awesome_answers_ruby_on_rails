class ContactsController < ApplicationController
    def new
    end
  
    def create
        # we define instance variables are accessible to be able to access the variables in the corresponding view file.
        @name = params["name"]
        @message = params["message"]
    end
end
  