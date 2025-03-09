class RepliesController < ApplicationController

    before_action :set_reply, only: %i[ show edit update destroy ]

    def show
    end

    def create
        @post = Post.find_by(id: params[:reply][:post_id])
        
        # Handle case where the post is not found
        if @post.nil?
          redirect_to posts_path, alert: "Post not found."
          return
        end
      
        @reply = @post.replies.build(reply_params)
        @reply.user = current_user
      
        # Attempt to save the reply
        if @reply.save
            per_page = Rails.application.config.default_pagination_limit
            last_page = (@post.replies.count.to_f / per_page).ceil
            redirect_to post_path(@post, page: last_page), notice: "Reply was successfully created."
        else
          # If there are validation errors, render the post page again with errors
          flash.now[:alert] = "There was an error creating your reply."
          render 'posts/show', status: :unprocessable_entity
        end
    end

    def edit
        # show post in reply edit mode
        @edit_reply = params[:id]
        redirect_to post_path(@reply.post, edit_reply: @edit_reply)
    end

    def update
        respond_to do |format|
            if @reply.update(reply_params)
                format.html { redirect_to post_path(@reply.post), notice: "Reply was successfully updated." }
            else
                format.html { render :edit, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @reply = Reply.find(params[:id])
        @reply.destroy!
        redirect_to post_path(@reply.post), notice: "Reply was successfully destroyed."
    end
      
    private
        def reply_params
            params.require(:reply).permit(:body, :post_id)
        end

        def set_reply
            @reply = Reply.find(params[:id])
        end
end
