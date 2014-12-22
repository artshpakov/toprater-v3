class Observers::Debug

  def initialize 
    reset!
  end

  def notify event, url
    if event == 'fetch'
      @api_calls << url
    end
  end

  def api_calls
    @api_calls
  end

  def reset!
    @api_calls = []
  end

end
