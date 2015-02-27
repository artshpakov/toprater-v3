class SearchController < ApplicationController

  respond_to :json

  FILTERS = { 
              movies: %w(genres actors),
              companies: %w(industries segm),
              hotels: []
            }

  def suggest
    result = {}
    result[:props] = complete_props params[:q], State.sphere
    result[:objects] = Sentimeta::Client.search(text: params[:q])['objects']
    render json: result
  end

  def global
    if State.sphere == 'movies'
      result = complete_movies params[:q]
    else
      result = []
    end
    render json: result
  end

  def objects
    render json: Sentimeta::Client.search(text: params[:q])['objects']
  end

  def search
    response = Sentimeta::Client.fetch(:search, text: params[:term], sphere: params[:sphere])
    if response.ok?
      respond_with response.body
    else
      render nothing: true, status: :bad_request
    end
  end


  private

  def complete_props query, sphere
    result = Sentimeta::Client.search(text: query)['criteria'].map{ |a| a.merge({type: :criteria}) }
    FILTERS[sphere.to_sym].each do |filter|
      result += Sentimeta::Client.search(where: filter, text: query).map{ |a| a.merge({type: filter}) }
    end
    result
  end

end
