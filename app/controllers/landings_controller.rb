class LandingsController < ApplicationController

  layout false
  skip_before_action :set_locale, :set_sphere, :setup

  respond_to :json


  def similar_movies
  end

  def search
    I18n.locale       = params[:locale]
    Sentimeta.sphere  = params[:sphere]
    respond_with Sentimeta::Client.fetch :search, text: params[:term]
  end

end
