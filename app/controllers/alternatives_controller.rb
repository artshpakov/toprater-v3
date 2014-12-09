class AlternativesController < ApplicationController

  respond_to :json


  def index
    @alternatives = Sentimeta::Client.objects criteria: params[:criteria], filters: params[:filters]
    if request.xhr?
      return render "alternatives/index", layout: false
    end
  end

end
