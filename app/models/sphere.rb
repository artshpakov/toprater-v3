class Sphere

  def self.all
    Rails.cache.fetch "spheres" do
      Sentimeta::Client.spheres
    end
  end

  def self.leafs
    all.flat_map do |sphere|
      sphere['issphere'].nil? || sphere['issphere'] ? sphere : sphere['categories']
    end
  end

end
