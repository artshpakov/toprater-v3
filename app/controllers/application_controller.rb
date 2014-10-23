class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception


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
    @criteria     = Criterion.all
    gon.criteria  = Criterion.leafs
  end

end
