class AlternativesController < ApplicationController

  respond_to :json


  def index
    @alternatives = Sentimeta::Client.objects state.to_hash.slice(:criteria, :filters).merge fields: { limit_objects: 3 }
  end


  def show
    unless @alternative = Sentimeta::Client.fetch(:objects, id: params[:id])['object']
      raise ActionController::RoutingError.new('Record not found')
    end
  end

end
