class SEO::CompaniesDecorator < SEO::AlternativeDecorator

  def description
    object.extra['description']
  end

  def og_hash
    {
      title: title,
      url: canonical_url,
      image: object.cover,
      description: description,
      site_name: 'toprater.com',
      type: 'toprater_com:company'
    }
  end

  def canonical_url
    "https://toprater/en/companies/objects/#{object.id}"
  end

  def keywords
    str = "TopRater.com, user ratings, user reviews, companies, employers, #{object.name}, "
    str += object.top_criteria.map { |key, value| value['label'] }.join ', '
  end

end
