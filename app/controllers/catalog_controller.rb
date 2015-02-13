class CatalogController < ApplicationController

  def catalog
    response = Sentimeta::Client.fetch :catalog, path: params[:path]
    if response.ok?
      @path     = response.body['path']
      @content  = Sentimeta::Client.fetch :infotext, { lang: 'en', param: "catalog-annotation", data: { path: params[:path] }}
      @catalog  = response.body['catalog']
      @objects  = response.body['objects']
    end
  end

end
