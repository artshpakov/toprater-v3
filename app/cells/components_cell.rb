class ComponentsCell < TopraterCell

  DEFAULT_ZOOM = 12 # 18 is Google's max

  def map args
    @title  = args[:title] || (args[:path].presence && args[:path].last['label'])
    @zoom   = (args[:path].presence && args[:path].count*4) || DEFAULT_ZOOM
    @geo    = args[:geo] || begin
      # TODO temporary
      JSON.parse(RestClient.get("http://maps.googleapis.com/maps/api/geocode/json?address=#{ args[:location].split('/').last }"))['results'].first['geometry']['location'] rescue nil
    end
    p @title, @zoom, @geo
    render
  end

end
