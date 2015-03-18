class SEO::MoviesDecorator < SEO::AlternativeDecorator

  def description
    object.extra['summary']
  end

  def canonical_url
    "https://toprater/en/movies/objects/#{object.id}"
  end

  def keywords
    str = "TopRater.com, user ratings, user reviews, films, movies, #{object.name}, "
    str += object.genres.join ', '
    str += object.top_criteria.map { |key, value| value['label'] }.join ', '
  end

end
