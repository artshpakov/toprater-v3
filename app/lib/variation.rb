class Variation

  class << self

    attr_accessor :config, :registry

    def init!
      self.registry = {}
    end

    def create name, &block
      new(name, &block).tap do |variation|
        all.push variation
      end
    end

    def all
      @tests ||= []
    end

    def get name
      all.find { |t| t.name == name }
    end

    def config_for name
      @config[name]
    end
  end


  attr_accessor :name, :logic

  def initialize name, &block
    self.name   = name
    self.logic  = block_given? ? block : Proc.new { |variants| variants.sample }
  end

  def variant
    Variation.registry[name] ||= begin
      Rails.logger.debug "CALLING LOGIC FOR #{ name } VARIATION"
      variants = self.class.config_for(name)
      if variants.kind_of?(Array) && variants.count > 1
        logic.call variants
      else
        variants
      end
    end
  end

end
