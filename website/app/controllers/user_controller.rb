class UserController < ApplicationController


    def index

    end

    def login
        render :login, :layout => nil
    end
end
