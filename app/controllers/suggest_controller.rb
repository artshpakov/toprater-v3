class SuggestController < ApplicationController
  def suggest
    result = Sentimeta::Client.search where: params[:scope], text: params[:q]
    render json: result
  end

  def global
    if State.sphere = 'movies'
      result = complete_movies params[:q]
    else
      result = []
    end
    render json: result
  end

  private

  def complete_movies(query)
    result = []
    %w(actors genres).each do |filter|
      result += Sentimeta::Client.search(where: filter, text: query).map{ |a| a.merge({type: filter}) }
    end
    result += Sentimeta::Client.search(text: query)['criteria'].map{ |a| a.merge({type: :criteria}) }
    result
  end
end
