class SEO::AlternativeDecorator < Draper::Decorator

  delegate_all


  def title
    "#{object.name}, #{object.review_ratings['total']} user reviews & ratings"
  end

  def description
    object.extra['description']
  end

end
