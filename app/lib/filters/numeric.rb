class Filters::Numeric

  def self.encode value
    if value['from'] == value['to']
      value['from']
    else
      "#{ value['from'] }-#{ value['to'] }"
    end
  end

  def self.decode value
    from, to = value.split('-')
    to ||= from
    { from: from, to: to }
  end
  
end
