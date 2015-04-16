redis_config = if ENV['REDIS_HOST'] && ENV['REDIS_PORT']
  { host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'] }
else
  YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env].symbolize_keys
end

KeyValue = Redis.new redis_config
