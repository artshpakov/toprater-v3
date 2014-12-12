class Observers::Debug

  def initialize 
    @api_calls = []
  end

  def notify event, url
    if event == 'fetch'
      @api_calls << url
    end
  end

  def api_calls
    @api_calls
  end

end
