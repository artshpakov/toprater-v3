module ApplicationHelper

  def solid &block
    begin
      with_output_buffer { yield }
    rescue Exception => e
      Rails.logger.error "  #{ 'RENDER ERROR:'.red } #{ e } -- #{ e.backtrace.first }"
      return
    end
  end

end
