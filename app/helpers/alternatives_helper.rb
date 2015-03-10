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

  def widget_path options
    "http://5.9.0.5/widget/#{ options.delete(:id) }?p=#{ options.merge(type: 1, scheme: :light).to_json }" #TODO temporary
  end

end
