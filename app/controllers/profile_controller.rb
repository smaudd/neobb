class ProfileController < ApplicationController

    def index
        render "profile/index"
    end

    def show
        @user = User.find_by(username: params[:username])
    end
end
