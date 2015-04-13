class MedalsController < ApplicationController

  def show
    response = Sentimeta::Client.medal params[:id], criteria: params[:criteria], filters: params[:filters]
    if response.ok?
      @award = response.body
      gon.push\
        id: params[:id],
        hash: Digest::MD5.hexdigest("#{ params[:id] }#{ Time.now }")[0..4]
    end
  end

end
