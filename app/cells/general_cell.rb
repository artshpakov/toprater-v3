class GeneralCell < TopraterCell

  def spheres
    @spheres = Rails.cache.fetch "spheres" do
      Sentimeta::Client.spheres
    end
    render
  end


  def criteria_catalog
    @criteria = Criterion.all
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
      render
    end
  end

end
