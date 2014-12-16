class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  layout :set_layout
  def set_layout
    request.xhr? ? false : 'application'
  end


  before_action :set_locale, :set_sphere, :setup


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
      @debug_observer = Observers::Debug.new
      Sentimeta::Observers.add @debug_observer
      cookies[:debug] = params[:debug].to_i if params[:debug].present?

      gon.criteria  = Criterion.leafs
      gon.state     = state.to_hash
    end
  end



  COMPLEX_URLS = %w(list)

  COMPLEX_URLS.each do |name|
    method_name = "#{ name }_path"
    define_method(method_name) { |options={}| super ParamsService.encode!(params).merge(options) }
    helper_method method_name
  end


  protected

  def state
    @state ||= begin
      Toprater::Application.state = State.init! params: params, cookies: cookies, session: session
    end
  end

end
