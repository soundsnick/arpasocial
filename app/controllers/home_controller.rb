class HomeController < ApplicationController

  def index
    if current_user
      posts = []
      current_user.posts.each {|post| posts.push post.id}
      current_user.subscriptions.each do |sub|
        to_user = User.find_by(id: sub.to_id)
        to_user.posts.each { |post| posts.push post.id}
      end
      @posts = Post.where(id: posts).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    else
      redirect_to new_user_session_path
    end
  end

end
