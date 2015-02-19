class Medal < OpenStruct#.new(:rank, :criteria, :filters)

  def criterion
    Criterion.find(criteria.first)
  end

  def location
    return 'In world' unless filters.present?
    return filters['city'].capitalize if filters['admin1']
    return filters['country'].capitalize if filters['country']
  end

  def scope
    return 'world' unless filters.present?
    return 'local' if filters['admin1']
    return 'country' if filters['country']
  end


end
