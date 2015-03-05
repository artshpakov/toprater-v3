class AlternativesController < ApplicationController

  respond_to :json

  LIMIT_OBJECTS = 5


  def index
    @alternatives = decorate Alternative.rate(limit_objects: LIMIT_OBJECTS, offset_objects: params[:offset].to_i)
    render :index, layout: results_layout
  end


  def show
    unless @alternative = Alternative.find(params[:id], fields: { limit_medals: 10 })
      raise Sentimeta::Error::RecordNotFound
    end
    @alternative = decorate @alternative
    @similar = @alternative.similar_objects.map { |object| Alternative.find(object['id']) } rescue []
  end


  protected

  def decorate object
    decorator = "#{ State.sphere.capitalize }Decorator".constantize rescue nil
    return object unless decorator && defined?(decorator)
    object.kind_of?(Array) ? decorator.decorate_collection(object) : decorator.decorate(object)
  end

  def results_layout
    return false if request.xhr?
    template = "alternatives/_#{ Sentimeta.sphere }"
    template_exists?(template, %w(layouts)) ? template : "alternatives/_default"
  end

end
