class Sphere

  def self.all
    Rails.cache.fetch "spheres" do
      Sentimeta::Client.spheres
    end
  end

  def self.leafs
    [].tap do |leafs|
      all.each do |sphere|
        if sphere['issphere'] == false
          leafs << sphere['categories']
        else
          leafs << sphere
        end
      end
    end.flatten
  end

end
