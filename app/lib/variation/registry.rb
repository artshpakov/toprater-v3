class Variation::Registry

  cattr_accessor :config, :registry

  class << self
    def init! token
      @token = token
      cache = KeyValue.hgetall("variations:#{ token }")
      self.registry = cache.update(cache) { |key, value| JSON.parse value }.symbolize_keys
    end

    def cache name, variant
      registry[name] = variant
      KeyValue.hset("variations:#{ @token }", name, variant.to_json)
    end
  end

end
