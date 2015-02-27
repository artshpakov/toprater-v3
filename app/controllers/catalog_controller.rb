class CatalogController < ApplicationController

  ITEMS_PER_PAGE = 60
  def items_per_page() ITEMS_PER_PAGE end
  helper_method :items_per_page

  before_action do
    @page = params[:page].try(:to_i) || 1
  end


  def catalog
    response = Sentimeta::Client.fetch :catalog, path: params[:path], limit: ITEMS_PER_PAGE, offset: (@page-1)*ITEMS_PER_PAGE
    if response.ok?
      @path         = response.body['path']
      @content      = Sentimeta::Client::Info.catalog(params[:path])
      @catalog      = response.body['catalog']
      @objects      = response.body['objects']
      @items_total  = response.body['total']

      # TODO temporary
      @geo          = JSON.parse(RestClient.get("http://maps.googleapis.com/maps/api/geocode/json?address=#{ @content['map'].split('/').last }"))['results'].first['geometry']['location'] rescue nil
    end
  end

  def index
    response = Sentimeta::Client.fetch "index/#{params[:path]}", limit: ITEMS_PER_PAGE
    if response.ok?
      @path   = response['breadcrumbs']
      @groups = response['next']
      @ratings = response['ratings']
    end
  end

end
