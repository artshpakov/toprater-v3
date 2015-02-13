class AlternativesController < ApplicationController

  respond_to :json

  LIMIT_OBJECTS = 3


  def index
    @alternatives = decorate Alternative.rate(limit_objects: LIMIT_OBJECTS, offset_objects: params[:offset].to_i)
  end


  def show
    unless @alternative = Alternative.find(params[:id])
      raise Sentimeta::Error::RecordNotFound
    end
    @alternative = decorate @alternative
  end


  protected

  def decorate object
    decorator = "#{ State.sphere.capitalize }Decorator".constantize rescue nil
    return object unless decorator && defined?(decorator)
    object.kind_of?(Array) ? decorator.decorate_collection(object) : decorator.decorate(object)
  end

end
