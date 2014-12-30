class LandingsController < ApplicationController

  layout false
  skip_before_action :set_sphere

  respond_to :json


  def similar
    Sentimeta.sphere = :movies
    if params['id'].present?
      @alternative = Alternative.find params[:id]
    end
  end

  def search
    I18n.locale       = params[:locale]
    Sentimeta.sphere  = params[:sphere]
    respond_with Sentimeta::Client.fetch :search, text: params[:term]
  end

end
