class LandingsController < ApplicationController

  layout false
  skip_before_action :set_locale, :set_sphere, :setup

  def similar_movies
  end

end
