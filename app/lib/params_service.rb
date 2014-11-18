class ParamsService

  RULES = {
    stars: {
      encode: ->(value) { "#{ value['from'] }-#{ value['to'] }" },

      decode: Proc.new do |value|
        from, to = value.split('-')
        { from: from, to: to }
      end
    },


    catalog: {
      encode: ->(value) { value.select { |e| e.present? }.join(',') },

      decode: Proc.new do |value|
        catalog = value.split(',')
        Array.new(3) { |i| catalog[i] || "" }
      end
    }
  }




  def self.decode! params
    params[:criteria] = params[:criteria].split(',') if params[:criteria].present? && params[:criteria].kind_of?(String)

    if params[:filters].present?
      hash = {}
      filters = params[:filters].split('/')
      while filters.present?
        key   = filters.shift.to_sym
        value = filters.shift
        hash[key] = RULES[key][:decode].call(value) rescue value
      end
      params[:filters] = hash
    end
  end


  def self.encode! params
    params[:criteria] = params[:criteria].join(',') if params[:criteria].present?
    params[:filters] = params[:filters].map do |key, value|
      key = key.to_sym
      [ key, RULES[key][:encode].call(value) ] rescue [key, value]
    end.flatten.join('/') if params[:filters].present?
    params
  end

end
