class Alternative < Sentimeta::Model

  endpoint :objects

  attr_accessor :id, :full_id, :name, :address, :photos, :reviews, :extra, :catalog


  def id
    full_id || id
  end

  def self.rate options
    fetch State.criteria_and_filters.merge(fields: options)
  end

  def self.find id
    data = Sentimeta::Client.fetch(:objects, id: id)['object']
    new data if data.present?
  end

  def stars
    extra['stars'].to_i.floor
  end

  def full_address
    address['full_address']
  end

  def cover
    photos.first['url'] if photos.present?
  end

  def price
    extra['price']
  end

end
