class AlternativesController < ApplicationController

  respond_to :json


  def index
    @alternatives = Sentimeta::Client.objects state.to_hash.slice(:criteria, :filters)
  end

end
