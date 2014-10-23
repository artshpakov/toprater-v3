class AlternativesController < ApplicationController

  respond_to :json
  layout false


  def index
    @alternatives = Sentimeta::Client.objects params[:p]
  end

end
