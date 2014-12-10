module ApplicationHelper

  def partial template, params={}, &block
    if lookup_context.exists?(template, [], true)
      render partial: template, locals: params[:locals]
    else
      block_given? && yield && ""
    end
  end


  def solid &block
    begin
      with_output_buffer { yield }
    rescue Exception => e
      Rails.logger.error "  #{ 'RENDER ERROR:'.red } #{ e } -- #{ e.backtrace.first }"
      return
    end
  end

end
