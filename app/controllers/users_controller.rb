class UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ]

    allow_unauthenticated_access only: [:new, :create]
    # require_role :admin
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
            format.html { redirect_to @user, notice: "User was successfully created." }
            format.json { render :show, status: :created, location: @user }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @user.errors, status: :unprocessable_entity }
        end
        end
    end

    def update
        respond_to do |format|
            if @user.update(user_params)
                if user_params[:avatar]
                    @user.avatar.attach(user_params[:avatar])
                end
                format.html { redirect_to @user, notice: "User was successfully updated." }
                format.json { render :show, status: :ok, location: @user }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @user.destroy!
    
        respond_to do |format|
          format.html { redirect_to users_path, status: :see_other, notice: "User was successfully destroyed." }
          format.json { head :no_content }
        end
    end

    def ban
        @user = User.find(params.require(:id))
        @ban = @user.bans.new(reason: ban_params)
        @ban.banned_at = Time.current
        respond_to do |format|
            if @ban.save
                format.html { redirect_to @user, notice: "User was successfully banned." }
            else
                format.html { redirect_to @user, notice: "Problems banning user." }
            end
        end
    end

    def unban
        @user = User.find(params.require(:id))
        @ban = @user.bans.first
        if @ban.nil?
            respond_to do |format|
                format.html { redirect_to @user, notice: "User is not banned." }
            end
            return
        end
        @ban.destroy!
        respond_to do |format|
            format.html { redirect_to @user, notice: "User was successfully unbanned." }
        end
    end

    private
        def set_user
            @user = User.find(params.require(:id))
        end

        def user_params
            params.expect(user: [:username, :email_address, :password, :role, :avatar])
        end

        def ban_params
            params.expect(:reason)
        end
end
