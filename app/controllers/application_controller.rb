class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  layout :set_layout
  def set_layout
    request.xhr? ? false : 'application'
  end

  before_action :set_locale, :set_sphere, :set_hints, :setup

  def set_locale
    unless params[:locale].present?
      params[:locale] = :en
      return redirect_to params
    end
    I18n.locale = params[:locale]
  end

  def set_hints
    unless cookies[:hints_off] || Sentimeta.sphere.nil?
      gon.hints = HintsDecorator.decorate_collection(Sentimeta::Client::Info.hints)
      cookies[:hints_off] = true
    end
  end

  def set_sphere
    Sentimeta.sphere = params[:sphere] if params[:sphere].present?
  end

  def setup
    State.init! params: params, cookies: cookies, session: session

    unless request.xhr?
      Variation::Registry.init!(cookies[:token] ||= SecureRandom.uuid)
      Variation.create(:reviews)
      Variation.create(:actors)
      
      Sentimeta::Observers.debug.try :reset!

      gon.filters   = F_PRESETS[State.sphere]
      gon.criteria  = Criterion.leafs
      gon.state     = State.to_hash
    end
  end


  helper_method :current_user, :signed_in?

  def current_user
    @current_user ||= if session[:auth].present?
      User.find(session[:auth]['token']) || session.clear
    end
  end

  def signed_in?
    current_user.present?
  end



  COMPLEX_URLS = %w(list object)

  COMPLEX_URLS.each do |name|
    method_name = "#{ name }_path"
    define_method(method_name) { |options={}| super(ParamsService.encode(options)).split('?').first }
    helper_method method_name
  end

end
