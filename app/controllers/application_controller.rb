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
       # TODO move to a initializer
      config = YAML.load_file("#{Rails.root}/config/variations.yml").symbolize_keys
      Variation.init! config
      Variation.create :reviews
      Variation.create :actors

      # TODO move to a initializer
      @debug_observer = Observers::Debug.new
      Sentimeta::Observers.add @debug_observer

      gon.criteria    = Criterion.leafs
      gon.state       = State.to_hash
    end
  end



  COMPLEX_URLS = %w(list object)

  COMPLEX_URLS.each do |name|
    method_name = "#{ name }_path"
    define_method(method_name) { |options={}| super(ParamsService.encode!(params).merge(options)).split('?').first }
    helper_method method_name
  end

end
