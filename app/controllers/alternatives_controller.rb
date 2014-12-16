class AlternativesController < ApplicationController

  respond_to :json

  LIMIT_OBJECTS = 3


  def index
    @alternatives = Alternative.rate limit_objects: LIMIT_OBJECTS
  end


  def show
    unless @alternative = Alternative.find(params[:id])
      raise Sentimeta::Error::RecordNotFound
    end
  end

end
