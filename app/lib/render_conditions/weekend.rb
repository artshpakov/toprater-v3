module RenderConditions
  class Weekend
    def self.choose_variant
      (Date.today.saturday? || Date.today.sunday?) ? 0 : 1
    end
  end
end
