class PostsController < ApplicationController

  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
  end

  def show
    @reply = Reply.new
    if params[:edit_reply]
      @reply = Reply.find(params[:edit_reply].to_i)
    end
    per_page =  Rails.application.config.default_pagination_limit
    @replies, @total_pages, @page = paginate(Reply.where(post_id: @post.id), per_page: per_page)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find_by(slug: params[:id])
    
      if @post.nil?
        # TODO: Show a 404 page instead
        redirect_to posts_path, alert: "Post not found."
      end
    end
  

    def post_params
      params.expect(post: [:title, :body, :published, :topic_id, :user_id])
    end
end
