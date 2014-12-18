config = YAML.load_file("#{Rails.root}/config/variations.yml").symbolize_keys
Variation.config = config

Variation.create(:reviews)
Variation.create(:actors)
