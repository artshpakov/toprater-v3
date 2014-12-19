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

    def encoded_filters
      new_filters = {}
      filters.each do |filter|
        f_type = F_PRESETS[sphere][filter[0]]['kind']
        new_filters[filter[0]] = "Filters::#{ f_type.capitalize }".constantize.encode(filter[1])
      end if filters.present?
      new_filters
    end

    def to_hash(for_front=false)
      { locale: locale, sphere: sphere, criteria: criteria, filters: (for_front ? encoded_filters : filters), options: options }
    end


    def criteria_and_filters
      { criteria: criteria, filters: filters }
    end


    def debug?() debug end

  end

end
