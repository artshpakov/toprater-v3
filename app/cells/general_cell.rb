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


  def debug options
    if State.debug?
      @state      = State.to_hash
      @api_calls  = options[:observer].api_calls
      render
    end
  end

end
