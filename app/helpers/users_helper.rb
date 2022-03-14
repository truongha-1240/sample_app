module UsersHelper
  def gravatar_for user, options = {size: Settings.size.size_80}
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = Settings.link_gravatar + "/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def check_hidden_delete_button user
    current_user.admin? && !current_user?(user)
  end
end
