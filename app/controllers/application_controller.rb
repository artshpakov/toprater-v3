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

  def set_sphere # TODO temporary -- remove later
    unless params[:sphere].present?
      params[:sphere] = :hotels
      return redirect_to params
    end
    Sentimeta.sphere = params[:sphere]
  end

  def setup
    State.init! params: params, cookies: cookies, session: session

    unless request.xhr?
      Variation::Registry.init!(cookies[:token] ||= SecureRandom.uuid)
      Variation.create(:reviews)
      Variation.create(:actors)

      Sentimeta::Observers.debug.try :reset!

      gon.criteria  = Criterion.leafs
      gon.state     = State.to_hash(true)
    end
  end



  COMPLEX_URLS = %w(list object)

  COMPLEX_URLS.each do |name|
    method_name = "#{ name }_path"
    define_method(method_name) { |options={}| super(ParamsService.encode(params).merge(options)).split('?').first }
    helper_method method_name
  end

end
