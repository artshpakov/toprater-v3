class MedalsController < ApplicationController

  def show
    response = Sentimeta::Client.medal params[:id], criteria: params[:criteria], filters: params[:filters]
    if response.ok?
      @award = response.body
      gon.push\
        id: params[:id],
        hash: Digest::MD5.hexdigest("#{ params[:id] }#{ Time.now }")[0..4],
        current_hotel_link: object_url(id: response.body['object']['full_id'], criteria: nil, filters: nil),
        current_hotel_name: response.body['object']['name']
    end
  end

end
