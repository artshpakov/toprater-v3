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

  def render_variant name, params={}
    opts = RENDER_VARIANTS[name]
    if opts['render'] == 'template'
      conditional_render opts['condition'].constantize, opts['variants'][0], opts['variants'][1], params
    else
      conditional_string opts['condition'].constantize, opts['variants'][0], opts['variants'][1]
    end
  end

  def sphere
    Sentimeta.sphere
  end

  private

  def conditional_render condition, template1, template2, params={}
    condition.send(:choose_variant) ? render_partial(template1, params) : render_partial(template2, params)
  end

  def conditional_string condition, string1, string2
    condition.send(:choose_variant) ? string1 : string2
  end

end
