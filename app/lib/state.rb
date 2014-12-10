class State

  attr_accessor :locale, :sphere, :criteria, :filters, :options


  def self.init! params
    ParamsService.decode! params
    new.tap do |state|
      dup = params.dup
      state.locale    = dup.delete :locale
      state.sphere    = dup.delete :sphere
      state.criteria  = dup.delete :criteria
      state.filters   = dup.delete :filters
      state.options   = dup.reject { |key, value| key.in? %w(controller action) }
    end
  end

  def to_hash
    { locale: locale, sphere: sphere, criteria: criteria, filters: filters, options: options }
  end

end
