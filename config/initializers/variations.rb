Split.configure do |config|
  config.experiments = YAML.load_file "config/variations.yml"
  config.persistence = Split::Persistence::RedisAdapter.with_config(lookup_by: proc { |context| context.cookies[:ab_token] })
  config.allow_multiple_experiments = true
end
