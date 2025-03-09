class PersonalizationDataController < ApplicationController
    before_action :set_personalization_data, only: [:update]
    before_action :set_defaults, only: [:create]
  
    def update
      if @personalization_data.update(personalization_data_params)
        flash[:notice] = "Personalization updated successfully."
      else
        flash[:alert] = "Failed to update personalization."
      end
  
      redirect_to profile_edit_path
    end
  
    def create
      # Ensure we are creating personalization data for the current user
      @personalization_data = current_user.build_personalization_data(personalization_data_params)
  
      if @personalization_data.save
        flash[:notice] = "Personalization created successfully."
      else
        flash[:alert] = "Failed to create personalization."
      end
      redirect_to profile_edit_path
    end
  
    private
  
    # Generate a random hex color if not provided
    def random_hex_color
      "#%06x" % rand(0..0xFFFFFF)
    end
  
    # Set default values for background_color and color if they are not set
    def set_defaults
      @personalization_data ||= current_user.build_personalization_data
      @personalization_data.color ||= random_hex_color
    end
  
    def set_personalization_data
      @personalization_data = current_user.personalization_data
    end
  
    def personalization_data_params
      params.require(:personalization_data).permit(:color, :avatar, :background_image, :bio).merge(user_id: current_user.id)
    end
  end
  