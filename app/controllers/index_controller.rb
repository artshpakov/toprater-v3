class IndexController < ApplicationController

  layout false

  skip_before_filter :set_sphere

  def index
    @presets = {}
    @main = {}
    @spheres = %w(movies hotels)
    @spheres.each do |sphere|
      @presets[sphere] = Sentimeta::Client.fetch :infotext, { sphere: sphere, lang: 'en', design: 'std', param: 'presets' }
      @main[sphere] = Sentimeta::Client.fetch :infotext, { sphere: sphere, lang: 'en', design: 'std', param: 'main' }
    end
    Sentimeta.sphere = :movies
    @popular = @main['movies']['popular'].map { |item| Alternative.find(item) }
  end

end
