class LandingsController < ApplicationController

  layout false
  skip_before_action :set_sphere, :setup, :set_hints
  OBJECTS_LIMIT = 10

  def employers

    Sentimeta.sphere = params[:sphere] = 'companies'
    params[:limit_objects] = OBJECTS_LIMIT
    params[:limit_criteria] = 15

    setup
    info_data = Sentimeta::Client.fetch :infotext, { design: "nyt", param: "landing", lang: "en" }
    segments = Sentimeta::Client.fetch('attributes/segm')['values']

    @worst_exist = info_data.body["data"]["worst"].present? rescue false

    if params[:reverse]
      params[:criteria] = info_data.body["data"]["worst"]["criteria"] rescue false
      params[:filters] = info_data.body["data"]["worst"]["filters"] rescue false
      @employers = Alternative.rate(params).reverse
      @reverse = true

    else
      params[:criteria] = info_data.body["data"]["best"]["criteria"] rescue false
      params[:filters] = info_data.body["data"]["best"]["filters"] rescue false
      @employers = Alternative.rate(params)
      @reverse = false
    end

    @title = info_data.body["data"]["title"] rescue false
    @about = info_data.body["data"]["about_rating"] rescue false
    @important_criteria = info_data.body["data"]["important_criteria"].map { |criterion| Criterion.find criterion } rescue false
    @find_company_title = info_data.body["data"]["find_company_title"] rescue false
    @check_company_title = info_data.body["data"]["check_company_title"] rescue false
    @find_company_text = info_data.body["data"]["find_company_text"] rescue false
    @check_company_text = info_data.body["data"]["check_company_text"] rescue false
    @segments = segments

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
