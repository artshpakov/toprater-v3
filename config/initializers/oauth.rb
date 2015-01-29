config = YAML.load_file(Rails.root.join('config', 'oauth.yml'))[Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  config.each do |name, options|
    provider name, options['id'], options['secret'], name: (options['name'] || name)
  end
end
