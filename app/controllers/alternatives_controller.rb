class AlternativesController < ApplicationController

  respond_to :json


  def index
    @alternatives = Sentimeta::Client.objects criteria: api_params
    if request.xhr?
      return render "alternatives/index", layout: false
    end
  end


  protected

  def api_params
    criteria = if params[:criteria].kind_of?(Array)
      params[:criteria]
    else
      JSON.parse params[:criteria]
    end
  end

end
