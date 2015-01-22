class AuthController < ApplicationController

  skip_before_action :set_locale, :set_sphere, :setup

  def signin
    response = Sentimeta::Client::Auth.signin params[:user]
    sign_user_in(response.body) if response.ok?
    redirect_to URI(request.referer).path
  end

  def signup
    response = Sentimeta::Client::Auth.signup params[:user]
    sign_user_in(response.body) if response.ok?
    redirect_to URI(request.referer).path
  end

  def signout
    session.clear
    redirect_to URI(request.referer).path
  end

  def callback
    params = env["omniauth.auth"].slice(:provider, :uid)
    response = Sentimeta::Client::Auth.oauth params
    sign_user_in(response.body) if response.ok?
    redirect_to URI(request.referer).path
  end


  private

  def sign_user_in auth_data
    session[:auth] = auth_data
  end

end
