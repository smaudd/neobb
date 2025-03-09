class RepliesController < ApplicationController

    def create
        @post = Post.find_by(id: params[:reply][:post_id])
        puts "POST: #{@post}"
        puts "PARAMS: #{params}"
        @reply = @post.replies.build(reply_params)
        @reply.user_id = current_user.id

        respond_to do |format|
            if @reply.save
                format.html { redirect_to @post, notice: "Reply was successfully created." }
            else
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    private
        def reply_params
            params.require(:reply).permit(:body, :post_id)
        end
end
