class User < OpenStruct

  def name() label end

  def self.find token
    response = Sentimeta::Client::Auth.user(token)
    new response.body if response.ok?
  end

end
