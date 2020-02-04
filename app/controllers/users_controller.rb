class UsersController < ApplicationController
  def profile
    if @user = User.find_by(username: params[:username])
      render 'profile'
    else
      redirect_to root_path, notice: 'Not found'
    end
  end

  def index
    if @user = User.find_by(username: params[:username])
      render 'profile'
    else
      redirect_to root_path, notice: 'Not found'
    end
  end

  def subscribe
    if current_user
      if @u = User.find_by(username: params[:username])
        if @s = current_user.subscriptions.find_by(to_id: @u.id)
          @s.destroy
        else
          @s = Subscription.new
          @s.user_id = current_user.id
          @s.to_id = @u.id
          @s.save
        end
        redirect_back fallback_location: root_path
      else
        redirect_to root_path, notice: 'Not found'
      end
    else
      redirect_to new_user_session_path
    end
  end

  def profiles
    @users = User.all.paginate(page: params[:page], per_page: 10)
    @search = User.where('username like ? or name like ? or surname like ?', "#{params[:query]}%", "#{params[:query]}%", "#{params[:query]}%") if params[:query]
  end
end
