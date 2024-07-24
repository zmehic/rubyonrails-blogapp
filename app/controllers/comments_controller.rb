class CommentsController < ApplicationController
  before_action :set_comment, only: [ :like, :edit, :update, :destroy ]

  def index
    @blog_post = BlogPost.find(params[:blog_post_id])
  end

  def new
    @blog_post = BlogPost.find(params[:blog_post_id])
    @comment = Comment.new
  end

  def create
    @blog_post = BlogPost.find(params[:blog_post_id])
    @comment = @blog_post.comments.new(comment_params)
    if @comment.save
      turbo_stream
    else
      render :new, status: :unprocessable_entity
    end
  end

  def like
    if @comment.likes.nil?
      @comment.likes = 0
    end
    @comment.likes += 1
    if @comment.save
      redirect_to blog_post_path(BlogPost.find(params[:blog_post_id]))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to blog_post_path(@blog_post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    turbo_stream
  end

  private

  def comment_params
    params.require(:comment).permit(:user, :body, :blog_post_id)
  end

  def set_comment
    @blog_post = BlogPost.find(params[:blog_post_id])
    @comment = @blog_post.comments.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
