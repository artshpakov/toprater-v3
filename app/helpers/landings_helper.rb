module LandingsHelper

  def rating value
    format '%.2f', (value+1)*2.5
  end

end
