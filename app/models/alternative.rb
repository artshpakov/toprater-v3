class Alternative < Sentimeta::Model

  endpoint :objects

  attr_accessor :id, :full_id, :name, :address, :photos, :reviews, :extra, :catalog, :top_criteria, :overall_rating, :review_ratings


  def full_id() @full_id || id end

  def self.rate options
    fetch \
      criteria: (options.delete(:criteria) || State.criteria),
      filters: (options.delete(:filters) || State.filters),
      fields: options
  end

  def self.find id
    data = Sentimeta::Client.fetch(:objects, id: id)['object']
    new data if data.present?
  end

  def rating
    ((overall_rating + 1) * 2.5).round(2) rescue nil
  end

  def cover
    photos.find { |p| p['type']=='primary_image' }.try(:[], 'url') if photos.present?
  end

  def partners_data
    extra['partners_data'].map { |e| e['data'] }
  end

end
