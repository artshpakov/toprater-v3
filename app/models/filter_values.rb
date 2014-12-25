class FilterValues < Sentimeta::Model

  endpoint :attributes

  def self.by_filter(filter)
    Rails.cache.fetch "filter:#{ Sentimeta.sphere }:#{filter}" do
      Sentimeta::Client.attributes(filter: filter).map do |option|
        [option['label'], option['name']]
      end
    end
  end

end