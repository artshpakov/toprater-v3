class LandingsController < ApplicationController

  layout false
  skip_before_action :set_sphere, :setup, :set_hints
  OBJECTS_LIMIT = 1000

  def employers
    Sentimeta.sphere = params[:sphere] = 'companies'
    params[:limit_objects] = OBJECTS_LIMIT

    setup
    info_data = Sentimeta::Client.fetch :infotext, { design: "nyt", param: "landing", lang: "en" }



    if params[:reverse]
      params[:criteria] = info_data.body["data"]["worst"]["criteria"]
      params[:filters] = info_data.body["data"]["worst"]["filters"]
      @employers = Alternative.rate(params).reverse[0..9]
      @reverse = true
    else
      params[:criteria] = info_data.body["data"]["best"]["criteria"]
      params[:filters] = info_data.body["data"]["best"]["filters"]
      @employers = Alternative.rate(params)[0..9]
      @reverse = false
    end

      @limit = OBJECTS_LIMIT
      @title = info_data.body["data"]["title"]
      @about = info_data.body["data"]["about_rating"]
      @important_criteria = info_data.body["data"]["important_criteria"].map { |criterion| Criterion.find criterion }
      @find_company_title = info_data.body["data"]["find_company_title"]
      @check_company_title = info_data.body["data"]["check_company_title"]
      @find_company_text = info_data.body["data"]["find_company_text"]
      @check_company_text = info_data.body["data"]["check_company_text"]

      # if request.xhr?
      #   render json: @employers
      # end
  end

  def similar_movies
    # TODO warm up criteria cache!
    Sentimeta.sphere = :movies
    setup
    if params[:id].present?
      @alternative = Alternative.find params[:id]
      @similar = if @alternative.top_criteria.present?
        Alternative.rate criteria: @alternative.top_criteria.keys
      end
    end
  end

end
