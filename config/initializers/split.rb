config = YAML.load_file("#{Rails.root}/config/variations.yml").symbolize_keys
Variation::Registry.config = config
