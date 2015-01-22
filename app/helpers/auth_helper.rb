module AuthHelper

  def oauth_path provider
    "/auth/#{ provider }"
  end

end
