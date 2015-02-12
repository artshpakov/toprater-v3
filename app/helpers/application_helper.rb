module ApplicationHelper

  def render_partial template, params={}, &block
    if lookup_context.exists?(template, [], true)
      render partial: template, locals: params[:locals]
    elsif block_given?
      yield && ""
    else
      default_template = template.split('/')[0...-1].push('default').join('/')
      if lookup_context.exists?(default_template, [], true)
        render partial: default_template, locals: params[:locals]
      end
    end
  end


  def solid &block
    begin
      with_output_buffer { yield }
    rescue Exception => e
      Rails.logger.error "  #{ 'RENDER ERROR:'.colorize :red } #{ e } -- #{ e.backtrace.first }"
      return
    end
  end

  def variant name, params={}
    opts = RENDER_VARIANTS[name]
    opts['variants'][opts['condition'].constantize.send(:choose_variant)]
  end

  def sphere
    Sphere.leafs.find { |s| s['name'] == State.sphere }.try :[], 'label'
  end

end
