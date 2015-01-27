Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, "833040550095705", "10c86d2f8811fed0e2120352a8146e17", provider_ignores_state: true, callback_path: '/auth/facebook/callback'
  provider :twitter, "kxa2M6tVJNKsP74H31dlPqUNe", "lDlvfUmnSbRJqdKO8AHv1pUbUortjcAzLgG9ZQRInHKZvuu5JJ", provider_ignores_state: true
  provider :google_oauth2, "29511162814-k3dnk117e23qgp0giiokom4tov5ftifo.apps.googleusercontent.com", "iP9h9C79g8VlAcG3vMU1nwT4", name: :google, provider_ignores_state: true

end
