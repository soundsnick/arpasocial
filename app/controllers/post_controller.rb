class PostController < ApplicationController

  require 'pry'

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:show, :index]

  def new_publication; end

  def index
    if @post = Post.find_by(id: params[:id])

    else
      redirect_to root_path, notice: 'Запись не найдена'
    end
  end

  def like
    if @post = Post.find_by(id: params[:id])
      unless @post.likes.find_by(user_id: current_user.id)
        @like = Like.new
        @like.user_id = current_user.id
        @like.post_id = @post.id
        if @like.save
          render json: {
              response: "set",
              count: @post.likes.count
          }
        else
          render json: {
              response: "unset",
              count: @post.likes.count
          }
        end
      else
        @post.likes.find_by(user_id: current_user.id).destroy
        render json: {
            response: "unset",
            count: @post.likes.count
        }
      end
    else
      render json: {
          response: "error",
          count: @post.likes.count
      }
    end
  end

  def delete
    if @post = Post.find_by(id: params[:id]) and @post.user_id = current_user.id
      @post.destroy
      redirect_to root_path, notice: "Successfully deleted"
    else
      redirect_back fallback_location: root_path
    end
  end

  def publish
    @p = Post.new(params.require(:post).permit(:content, :title))
    @p.user_id = current_user.id
    if @p.save
      redirect_to root_path, notice: "Successfully published!"
    else
      redirect_to root_path, alert: "Something went wrong"
    end
  end

  def comment
    if @post = Post.find_by(id: params[:id])
      @c = Comment.new
      @c.user_id = current_user.id
      @c.content = params[:content]
      @c.post_id = @post.id
      @c.comment_id = params[:comment_id]
      @c.save
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path
    end
  end

  def comment_delete
    if @c = Comment.find_by(id: params[:id])
      @c.comments.each { |comment| comment.destroy }
      @c.destroy
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path
    end
  end

end
