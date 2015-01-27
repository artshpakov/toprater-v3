class AuthController < ApplicationController

  skip_before_action :set_locale, :set_sphere, :setup

  def signin
    response = Sentimeta::Client::Auth.signin params[:user]
    sign_user_in(response.body) if response.ok?
    render json: response.body, status: response.status
  end

  def signup
    response = Sentimeta::Client::Auth.signup params[:user]
    sign_user_in(response.body) if response.ok?
    render json: response.body, status: response.status
  end

  def signout
    session.clear
    redirect_to URI(request.referer).path
  end

  def callback
    raw_data = env["omniauth.auth"]["info"].merge(env["omniauth.auth"]["extra"]["raw_info"]).slice(:email, :first_name, :last_name, :image, :gender, :locale, :lang, :timezone, :location)
    response = Sentimeta::Client::Auth.oauth env["omniauth.auth"].slice(:provider, :uid).merge(raw_data: raw_data)
    sign_user_in(response.body) if response.ok?
    redirect_to root_path
  end

  def forgot_password
    response = Sentimeta::Client::Auth.reset_password_token params[:user][:login]
    if response.ok?
      AuthMailer.change_password(params[:user][:email], response.body['reset_password_token']).deliver
      redirect_to root_path, flash: { info: "Message sent to #{ params[:user][:login] }" }
    else
      redirect_to root_path, flash: { alert: "Unknown email address #{ params[:user][:login] }" }
    end
  end

  def change_password
    response = Sentimeta::Client::Auth.reset_password token: params[:token], password: params[:user][:password]
    if response.ok?
      sign_user_in(response.body)
      redirect_to root_path, flash: { info: "Password changed successfully" }
    else
      redirect_to root_path, flash: { alert: "Something went wrong, try again later" }
    end
  end


  private

  def sign_user_in auth_data
    session[:auth] = auth_data
  end

end
