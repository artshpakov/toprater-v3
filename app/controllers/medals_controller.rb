class MedalsController < ApplicationController

  def show
    response = Sentimeta::Client.medal params[:id], criteria: params[:criteria], filters: params[:filters]
    @award = response.body if response.ok?
  end

end
