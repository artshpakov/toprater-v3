class ReviewsController < ApplicationController
  def show
    render json: Sentimeta::Client::UserReviews.find(
      id: params[:id],
      criterion: params[:criterion],
      token: (session[:auth]['token'] if session[:auth])
    )
  end

  def create
    data = {
      id: params[:id],
      criterion: params[:criterion]
    }
    data[:rating] = params[:rating] if params[:rating]
    data[:review] = params[:review] if params[:review]
    if session[:auth]
      data[:token] = session[:auth]['token'] 
      render json: Sentimeta::Client::UserReviews.create(data)
    else
      render json: { status: 'Not Authored' }, status: 401
    end
  end
end
