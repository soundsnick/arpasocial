module ApplicationHelper

  def avatar(user)
    user.avatar.url.nil? ? asset_url('noava.png') : user.avatar.url
  end
end
