class SEO::AlternativeDecorator < Draper::Decorator

  delegate_all

  def og_hash
    {
      title: title,
      image: object.cover,
      description: description,
      site_name: 'toprater.com'
    }
  end

  def title
    "#{object.name}, #{object.review_ratings['total']} user reviews & ratings"
  end

  def description
    object.extra['description']
  end

end
