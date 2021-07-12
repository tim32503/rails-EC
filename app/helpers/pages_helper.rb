module PagesHelper
  def user_avatar
    image_tag(current_user.avatar_url, class: "rounded-circle", style: "width: 50px; height: 50px;") if current_user.avatar_url
  end
end
