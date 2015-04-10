module AlternativesHelper

  def catalog data
    data.map { |c| c['label'] }.reverse.join(', ')
  end

  def price_level price
    if price && price['range']
      (1..price['range']).map do |i|
        content_tag :span, '$', class: "price-level"
      end.join
    end
  end

  def rating_grade value
    return 'good' if value > 4
    return 'mediocre' if value > 2
    return 'bad'
  end

end
