class ParamsService

  def self.decode! params
    params[:criteria] = params[:criteria].split(',') if params[:criteria].present? && params[:criteria].kind_of?(String)

    if params[:filters].present?
      hash = {}
      filters = params[:filters].split('/')
      while filters.present?
        key   = filters.shift.to_sym
        value = filters.shift
        hash[key] = "Filters::#{ key.capitalize }".constantize.decode(value)
      end
      params[:filters] = hash
    end
  end


  def self.encode! params
    params[:criteria] = params[:criteria].join(',') if params[:criteria].present?
    params[:filters]  = params[:filters].map do |key, value|
      key = key.to_sym
      [ key, "Filters::#{ key.capitalize }".constantize.encode(value) ] rescue [key, value]
    end.flatten.join('/') if params[:filters].present?
    params
  end

end
