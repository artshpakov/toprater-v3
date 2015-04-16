class IndexCell < TopraterCell

  def important args
    @index = args[:index]
    Sentimeta.sphere = args[:sphere]
    criteria = Criterion.all
    @info = main(args[:sphere])['important']
    @criteria = presets(args[:sphere])['best_criteria']
    @sphere = Sentimeta.sphere
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

  def popular args
    Sentimeta.sphere = args[:sphere]
    @items = main(args[:sphere])['popular'].map { |item| Alternative.find(item) }
    render
  end

  def new_ratings args
    Sentimeta.sphere = args[:sphere]
    @ratings = main(args[:sphere])['new_ratings'].map do |rating|
      result = { name: rating.delete('label') }
      result[:alternatives] = Alternative.rate rating.symbolize_keys.merge({ limit_objects: 3 })
      result
    end
    render
  end


  protected

  def main sphere
    Rails.cache.fetch "info:main:#{ sphere }" do
      Sentimeta::Client::Info.main sphere: sphere
    end
  end

  def presets sphere
    Rails.cache.fetch "info:presets:#{ sphere }" do
      Sentimeta::Client::Info.presets sphere: sphere
    end    
  end

end
