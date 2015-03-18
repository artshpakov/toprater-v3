class SEO::HotelsDecorator < SEO::AlternativeDecorator

  def description
    object.extra['summary']
  end

  def canonical_url
    "https://toprater/en/hotels/objects/#{object.id}"
  end

  def keywords
    str = "TopRater.com, user ratings, user reviews, hotels, #{object.name}, "
    str += object.top_criteria.map { |key, value| value['label'] }.join ', '
  end

end
