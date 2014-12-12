class GeneralCell < Cell::Rails

  def criteria_catalog
    @criteria = Criterion.all
    render
  end


  def debug options
    if params[:debug].to_i == 1
      @state = Toprater::Application.state.to_hash
      @api_calls = options[:observer].api_calls
      render
    end
  end

end
