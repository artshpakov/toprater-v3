class SearchController < ApplicationController

  respond_to :json

  MOVIES_FILTERS = %w(genres actors)

  def suggest
    result = Sentimeta::Client.search where: params[:scope], text: params[:q]
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

  def complete_movies(query)
    result = Sentimeta::Client.search(text: query)['criteria'].map{ |a| a.merge({type: :criteria}) }
    MOVIES_FILTERS.each do |filter|
      result += Sentimeta::Client.search(where: filter, text: query).map{ |a| a.merge({type: filter}) }
    end
    result
  end
end
