class MoviesDecorator < Draper::Decorator

  delegate_all


  def name
    "#{ object.name } (#{ object.extra['year'] })"
  end

  def genres
    extra['genres'].map{ |dir| dir['label'] }
  end

  def top_cast
    extra['actors'].first(20) rescue []
  end

end
