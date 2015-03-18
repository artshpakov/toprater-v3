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
    @metatags = decorate @alternative, 'SEO'
    @reviews = Sentimeta::Client::UserReviews.find(
      id: params[:id],
      token: (session[:auth]['token'] if session[:auth])
    )
    @similar = @alternative.similar_objects.map { |object| Alternative.find(object['id']) } rescue []
  end


  protected

  def decorate object, prefix=nil
    decorator_name = prefix ? "#{prefix}::" : ''
    decorator_name += "#{ State.sphere.capitalize }Decorator"
    decorator = decorator_name.constantize rescue nil
    return object unless decorator && defined?(decorator)
    object.kind_of?(Array) ? decorator.decorate_collection(object) : decorator.decorate(object)
  end

  def results_layout
    return false if request.xhr?
    template = "alternatives/_#{ Sentimeta.sphere }"
    template_exists?(template, %w(layouts)) ? template : "alternatives/_default"
  end

end
