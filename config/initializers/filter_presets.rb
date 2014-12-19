F_PRESETS = {}
F_PRESETS['hotels'] = YAML.load_file(Rails.root.join('config/filters_data/hotels.yml'))
F_PRESETS['movies'] = YAML.load_file(Rails.root.join('config/filters_data/movies.yml'))