class MicroformatService

  def self.get property, value=nil
    property = property.to_s
    case true
    when property=='type'
      { itemscope: true, itemtype: "http://schema.org/#{ map_type(value || Sentimeta.sphere) }" }
    when %w(director actor writer producer musicBy).include?(property)
      { itemscope: true, itemtype: "http://schema.org/Person", itemprop: property }
    when property=='date'
      { itemprop: property, content: value }
    else
      { itemprop: property }
    end
  end


  private

  def self.map_type type
    if type.to_s.in?(%w(hotels movies)) # TODO add more
      type.singularize.capitalize
    else 'Product'
    end
  end

end
