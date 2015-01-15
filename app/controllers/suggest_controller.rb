class SuggestController < ApplicationController
  def suggest
    result = Sentimeta::Client.search where: params[:scope], text: params[:q]
    render json: result
  end
end
