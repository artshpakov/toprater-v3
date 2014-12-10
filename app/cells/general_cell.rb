class GeneralCell < Cell::Rails

  def criteria_catalog
    @criteria = Criterion.all
    render
  end

end
