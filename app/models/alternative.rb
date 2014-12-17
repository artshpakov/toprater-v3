class Alternative < Sentimeta::Model

  endpoint :objects

  attr_accessor :id, :name, :address, :photos, :reviews, :extra


  def self.rate options
    fetch Toprater::Application.state.criteria_and_filters.merge(fields: options)
  end

  def self.find id
    data = Sentimeta::Client.fetch(:objects, id: id)['object']
    new data if data.present?
  end


  def full_address
    address['full_address']
  end

  def cover
    photos.first['url']
  end

end
