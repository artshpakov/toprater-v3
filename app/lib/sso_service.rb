class SsoService

  API_KEY     = 'caff283abdf9c4af0a22fdbaf2366ea5'
  PROJECT_KEY = 'toprater'

  def self.token_for user
    message = {
      guid: user.id,
      expires_date: (Time.now + 3600*24).strftime("%Y-%m-%d %H:%M:%S"),
      email: user.email,
      display_name: user.name,
      locale: 'en',
      avatar_url: user.image
    }

    message_json = JSON.dump(message)

    key = EzCrypto::Key.with_password PROJECT_KEY, API_KEY
    encrypted_bytes = key.encrypt(message_json)

    CGI.escape([encrypted_bytes].pack('m0')).gsub('+','%2B')
  end

end
