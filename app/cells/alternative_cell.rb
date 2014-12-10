class AlternativeCell < Cell::Rails

  def index params
    @alternatives = params[:alternatives] || []
    render
  end

end
