class AlternativeCell < TopraterCell

  def index params
    @alternatives = params[:alternatives] || []
    render
  end

  def reviews params
    @reviews = params[:reviews]
    render
  end

end
