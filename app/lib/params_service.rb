class ParamsService

  def self.decode! params
    params[:criteria] = params[:criteria].split(',') if params[:criteria].present? && params[:criteria].kind_of?(String)

    if params[:filters].present?
      hash = {}
      filters = params[:filters].split('/')
      while filters.present?
        key   = filters.shift.to_sym
        value = filters.shift
        type = F_PRESETS[params[:sphere]][key.to_s]['kind']
        hash[key] = "Filters::#{ type.capitalize }".constantize.decode(value)
      end
      params[:filters] = hash
    end
  end


  def self.encode params
    criteria = Array.wrap(params[:criteria]).join(',') if params[:criteria].present?
    filters  = params[:filters].map do |key, value|
      key = key.to_sym
      [ key, "Filters::#{ key.capitalize }".constantize.encode(value) ] rescue [key, value]
    end.flatten.join('/') if params[:filters].present?
    { criteria: criteria, filters: filters }
  end

end
