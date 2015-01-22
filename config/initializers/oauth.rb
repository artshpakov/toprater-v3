Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, "778009828890303", "f11dbbfe3821b63883ad5c844ddcc69b", provider_ignores_state: true, callback_path: '/auth/facebook/callback'

  provider :twitter, "QICEypsZC5l5CqgdJbVT7eO4t", "xcsHAbpZ8KYaC9eWoTifypeemuoagAQe7WtsQGkw8aB7YJcMo2", provider_ignores_state: true

  provider :google_oauth2, "428047194229-h8nkf9rvi1d0psbr07fvek939h75p9gc.apps.googleusercontent.com", "H26rvGIlVM1aFAN6avK15Vca", name: :google, provider_ignores_state: true

end
