class PricesController < ApplicationController

  respond_to :json


  def index
    alternative = Alternative.find params[:id]

    prices_params = params[:prices].dup
    prices_params['nights'] = (Date.parse(prices_params.delete('until_date')) - Date.parse(prices_params['from_date'])).to_i

    prices = Sentimeta::Client.prices prices_params.merge \
      provider: :hotellook,
      # id: params[:id],
      data: alternative.partners_data.first
    respond_with prices
  end

end
