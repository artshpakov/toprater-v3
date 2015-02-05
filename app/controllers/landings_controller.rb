class LandingsController < ApplicationController

  layout false
  skip_before_action :set_sphere, :setup

  def employers
    Sentimeta.sphere = params[:sphere] = 'companies'
    setup
    if params[:id]
      render json: Alternative.find(params[:id])
    else
      @employers = Alternative.rate params
      if request.xhr?
        render json: @employers
      end
    end
  end

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

end
