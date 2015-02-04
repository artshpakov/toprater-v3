class MoviesDecorator < Draper::Decorator

  delegate_all

  def top_cast
    extra['actors'].first(20) rescue []
  end

end
