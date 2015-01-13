class LandingsController < ApplicationController

  layout false
  skip_before_action :set_sphere, :setup

  respond_to :json


  def similar_movies
    # TODO warm up criteria cache!
    Sentimeta.sphere = :movies
    setup
    if params[:id].present?
      @alternative = Alternative.find params[:id]
      @similar = if @alternative.top_criteria.present?
        Alternative.rate criteria: @alternative.top_criteria.keys
      end
    end
  end

  def search
    Sentimeta.sphere = params[:sphere]
    respond_with Sentimeta::Client.fetch :search, text: params[:term]
  end

end
