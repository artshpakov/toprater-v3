class LandingsController < ApplicationController

  layout false
  skip_before_action :set_sphere, :setup

  respond_to :json


  def similar
    # TODO warm up criteria cache!
    Sentimeta.sphere = :movies
    setup
    if params['id'].present?
      @alternative = Alternative.find params[:id]
      @similar = if @alternative.top_criteria.present?
        Sentimeta::Client.objects(criteria: @alternative.top_criteria.keys).map { |attrs| Alternative.new attrs }
      end
    end
  end

  def search
    I18n.locale       = params[:locale]
    Sentimeta.sphere  = params[:sphere]
    respond_with Sentimeta::Client.fetch :search, text: params[:term]
  end

end
