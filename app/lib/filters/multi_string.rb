class Filters::MultiString

  def self.encode value
    value.select { |e| e.present? }.join(',')
  end

  def self.decode value
    value.split(',')
  end

end
