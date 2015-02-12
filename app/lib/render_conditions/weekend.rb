module RenderConditions
  class Weekend
    def self.choose_variant
      Date.today.saturday? || Date.today.sunday?
    end
  end
end
