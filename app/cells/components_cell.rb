class ComponentsCell < TopraterCell

  def map args
    if args[:path] && args[:location]
      @path   = args[:path]
      @title  = @path.last['label']
      # TODO temporary
      @geo    = JSON.parse(RestClient.get("http://maps.googleapis.com/maps/api/geocode/json?address=#{ args[:location].split('/').last }"))['results'].first['geometry'] rescue nil
      render
    end
  end

end
