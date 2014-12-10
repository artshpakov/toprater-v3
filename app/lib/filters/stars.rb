class Filters::Stars

  def self.encode value
    "#{ value['from'] }-#{ value['to'] }"
  end

  def self.decode value
    from, to = value.split('-')
    { from: from, to: to }
  end
  
end
