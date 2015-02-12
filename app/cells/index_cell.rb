class IndexCell < TopraterCell

  def important args
    @index = args[:index]
    Sentimeta.sphere = args[:sphere]
    criteria = Criterion.all
    @info = main(args[:sphere])['important']
    @criteria = presets(args[:sphere])['best_criteria']
    render
  end

  def compilations
    @items = (presets(:movies)['best_ratings'] + presets(:hotels)['best_ratings']).shuffle.first(6)
    render
  end

  def recommendations args
    @info = main(args[:sphere])['recommend']
    render
  end

  def popular
    Sentimeta.sphere = :movies
    @items = main(:movies)['popular'].map { |item| Alternative.find(item) }
    render
  end


  protected

  def main sphere
    Rails.cache.fetch "info:main:#{ sphere }" do
      Sentimeta::Client.fetch(:infotext, { sphere: sphere, lang: State.locale, design: 'std', param: 'main' })
    end
  end

  def presets sphere
    Rails.cache.fetch "info:presets:#{ sphere }" do
      Sentimeta::Client.fetch(:infotext, { sphere: sphere, lang: State.locale, design: 'std', param: 'presets' })
    end    
  end

end
