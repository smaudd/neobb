class UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ban unban ]

    allow_unauthenticated_access only: [:new, :create]

    def index
        @users = User.all
    end

    def show
    end

    def new
        @user = User.new
    end

    def edit
    end

    def create
        @user = User.new(user_params)
        respond_to do |format|
            if @user.save
                if user_params[:avatar]
                    @user.avatar.attach(user_params[:avatar])
                end
                @user.personalization_data = PersonalizationData.new
                flash[:notice] = "User was successfully created."
                format.html { redirect_to root_path }
            else
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @user.update(user_params)
                if user_params[:avatar]
                    @user.avatar.attach(user_params[:avatar])
                end
                flash[:notice] = "User was successfully updated."
                format.html { redirect_to root_path }
            else
                format.html { render :edit, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @user.destroy!
        respond_to do |format|
            flash[:notice] = "User was successfully destroyed."
            format.html { redirect_to login_path, status: :see_other }
        end
    end

    def ban
        if @user.nil?
            redirect_to login, notice: "User not found"
            return
        end

        @ban = @user.bans.new(reason: ban_params[:reason])
        @ban.banned_at = Time.current
        respond_to do |format|
            if @ban.save
                flash[:notice] = "User was successfully banned."
                format.html { redirect_to root_path }
            else
                flash[:notice] = "Failed to ban user."
                format.html { redirect_to root_path }
            end
        end
    end

    def unban
        if @user.nil?
            flash[:notice] = "User not found"
            redirect_to login
            return
        end

        @ban = @user.bans.first
        if @ban.nil?
            respond_to do |format|
                flash[:notice] = "User is not banned."
                format.html { redirect_to root_path }
            end
            return
        end
        @ban.destroy!
        respond_to do |format|
            flash[:notice] = "User was successfully unbanned."
            format.html { redirect_to root_path }
        end
    end

    private
        def set_user
            @user = User.find_by(id: params[:id])
        end

        def user_params
            params.require(:user).permit(:username, :email_address, :password, :role, :avatar)
        end

        def ban_params
            params.require(:ban).permit(:reason)
        end
end
