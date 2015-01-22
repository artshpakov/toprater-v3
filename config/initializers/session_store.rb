redis_config = YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]

Rails.application.config.session_store :redis_store,
  servers:    [ host: redis_config[:host], port: redis_config[:port] ],
  key:        '_toprater_session',
  expire_in:  2.weeks,
  domain:     ('.toprater.com' if Rails.env.production?)
