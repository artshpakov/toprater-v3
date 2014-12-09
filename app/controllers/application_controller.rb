class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  layout :set_layout
  def set_layout
    request.xhr? ? false : 'application'
  end


  before_filter :set_locale, :set_sphere, :setup


  def set_locale
    unless params[:locale].present?
      params[:locale] = :en
      return redirect_to params
    end
    I18n.locale = params[:locale]
  end

  def set_sphere
    unless params[:sphere].present?
      params[:sphere] = :hotels
      return redirect_to params
    end
    Sentimeta.sphere = params[:sphere]
  end


  def setup
    unless request.xhr?
      @criteria     = Criterion.all
      # gon.criteria  = Criterion.leafs
      gon.criteria  = params[:criteria]
      gon.filters   = params[:filters]
    end
  end



  before_action do
    ParamsService.decode! params
  end


  COMPLEX_URLS = %w(list)

  COMPLEX_URLS.each do |name|
    method_name = "#{ name }_path"
    define_method(method_name) { |params={}| super ParamsService.encode! params }
    helper_method method_name
  end

end
