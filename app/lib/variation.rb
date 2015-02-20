class Variation

  attr_accessor :name, :strategy


  def self.create name, &block
    @variations ||= []
    new(name, &block).tap do |variation|
      @variations.push variation
    end
  end

  def self.get name
    @variations.find { |t| t.name == name } if @variations.present?
  end


  def initialize name, &block
    self.name     = name
    self.strategy = block_given? ? block : Proc.new { |variants| variants.sample }
  end

  def variant &block
    Variation::Registry.registry[name] || begin
      variants = Variation::Registry.config[name] rescue {}
      if variants.kind_of?(Array) && variants.count > 1
        variant = strategy.call variants
        block.call variant if block_given?
        variant
      else
        variants
      end
    end
  end

end
