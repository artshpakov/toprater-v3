module AuthHelper

  def oauth_path provider
    "/auth/#{ provider }"
  end

  def avatar image
    content_tag :span, nil, class: "avatar", style: "background-image: url(#{ image })"
  end

end
