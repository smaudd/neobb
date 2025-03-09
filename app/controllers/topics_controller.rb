class TopicsController < ApplicationController
  before_action :set_topic, only: %i[ show edit update destroy ]

  def index
    @topics = Topic.all
  end

  def show
    page = params[:page].presence&.to_i || 1  # Default to 1 if page is missing or invalid
    page = 1 if page < 1  # Ensure the page is at least 1
  
    @per_page = 1  # Number of records per page
    offset = (page - 1) * @per_page  # Correct the offset calculation
    @posts = Post.offset(offset).limit(@per_page).where(topic_id: @topic.id)
    # Calculate total pages based on the total number of posts
    @total_pages = (Post.where(topic_id: @topic.id).count.to_f / @per_page).ceil
  end
  

  def new
    @topic = Topic.new
  end

  def edit
  end

  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: "Topic was successfully created." }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: "Topic was successfully updated." }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @topic.destroy!

    respond_to do |format|
      format.html { redirect_to topics_path, status: :see_other, notice: "Topic was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_topic
      @topic = Topic.find(params.expect(:id))
    end

    def topic_params
      params.expect(topic: [ :name, :description, :category_id ])
    end
end
