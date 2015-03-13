class Alternative < Sentimeta::Model

  endpoint :objects

  attr_accessor :id, :full_id, :name, :address, :photos, :reviews, :coordinates, :extra, :catalog, :top_criteria, :overall_rating, :review_ratings, :similar_objects, :other_criteria, :medals


  def full_id() @full_id || id end

  def self.rate options
    fetch \
      criteria: (options.delete(:criteria) || State.criteria),
      filters: (options.delete(:filters) || State.filters),
      fields: options
  end

  def self.find id, options={}
    data = Sentimeta::Client.fetch(:objects, options.merge(id: id))['object']
    new data if data.present?
  end

  def rating
    ((overall_rating + 1) * 2.5).round(2) rescue nil
  end

  def cover
    entry = photos.find { |p| p['type']=='primary_image' } || photos.find { |p| p['type']=='photo' }
    entry.try(:[], 'hash').present? ? "https://api.toprater.com/api/v1/picture?hash=#{ entry['hash'] }" : entry['url']
  end

  def partners_data
    extra['partners_data'].map { |e| e['data'] }
  end

  def medals= medals
    @medals = medals.map { |m| Medal.new(m) }
  end

end
