class GeneralCell < TopraterCell

  def spheres
    @spheres = Sphere.all
    render
  end

  def criteria_catalog
    @criteria = Criterion.all
    render
  end

  def completer
    @sphere = Sphere.leafs.find { |s| s['name'] == State.sphere }
    render
  end

  def filters
    @available_filters = F_PRESETS[State.sphere]
    render
  end

  def debug
    if State.debug?
      @state      = State.to_hash
      @api_calls  = Sentimeta::Observers.debug.try :api_calls
      @variations = Variation::Registry.registry
      render
    end
  end

end
