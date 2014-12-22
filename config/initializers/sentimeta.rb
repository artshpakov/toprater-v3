Sentimeta.env = :staging unless Rails.env.production?

Sentimeta::Observers.add :debug, Observers::Debug.new
