class AlternativesController < ApplicationController

  respond_to :json


  def index
    @alternatives = Sentimeta::Client.objects criteria: params[:criteria], filters: params[:filters]
  end

end
