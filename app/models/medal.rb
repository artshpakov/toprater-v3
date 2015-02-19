class Medal < OpenStruct

  def criterion
    Criterion.find(criteria.first)
  end

end
