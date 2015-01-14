class State

  class << self

    attr_accessor :locale, :sphere, :criteria, :filters, :options, :debug

    def init! options
      options[:cookies]['debug'] = options[:params][:debug].to_i if options[:params][:debug].present?

      ParamsService.decode! options[:params]

      dup = options[:params].dup
      self.debug     = options[:cookies]['debug'].to_i == 1
      self.locale    = dup.delete :locale
      self.sphere    = dup.delete :sphere
      self.criteria  = dup.delete :criteria
      self.filters   = dup.delete :filters
      self.options   = dup.reject { |key, value| key.in? %w(controller action) }
    end

    def to_hash
      { locale: locale, sphere: sphere, criteria: criteria, filters: filters, options: options }
    end


    def debug?() debug end

  end

end
