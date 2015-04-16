class SubscribeController < ApplicationController
  skip_before_filter :set_locale
  def create
    if params[:email].present?
      result = Sentimeta::Client::Subscription.subscribe(params[:email])
      render json: result.body, status: result.status
    end
  end
end
