class Criterion < Sentimeta::Model

  endpoint :criteria

  attr_accessor :name, :label, :subcriteria


  def self.all
    Rails.cache.fetch "criteria:#{ Sentimeta.sphere }" do
      fetch(subcriteria: true).each do |root|
        root.subcriteria.map! { |criterion| new criterion }
      end
    end
  end

  def self.leafs # TODO move to a decorator
    all.flat_map &:subcriteria
  end

  def self.find name
    leafs.find { |c| c.name == name }
  end

end
