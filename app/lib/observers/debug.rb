class Observers::Debug

  def initialize 
    reset!
  end

  def notify event, request_details
    if event == 'fetch'
      @api_calls << request_details
    end
  end

  def api_calls
    @api_calls
  end

  def reset!
    @api_calls = []
  end

end
