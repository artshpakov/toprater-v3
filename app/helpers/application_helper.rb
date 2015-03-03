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

  def nested_layout template
    begin
      render template: template
    rescue ActionView::MissingTemplate
      default_template = template.split('/')[0...-1].push('_default').join('/')
      render template: default_template
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

  def ab_test name
    Variation.get(name).variant do |variant|
      Variation::Registry.cache(name, variant) if cookies[:token].present?
    end
  end

  def variant name, params={}
    opts = RENDER_VARIANTS[name]
    opts['variants'][opts['condition'].constantize.send(:choose_variant)]
  end

  def sphere
    Sphere.leafs.find { |s| s['name'] == State.sphere }.try :[], 'label'
  end


  def pagination total, per_page, link
    render partial: "partials/pagination", locals: {
      page_count: (total.to_f / per_page).ceil,
      current_page: (params[:page].try(:to_i) || 1),
      link: link
    }
  end

end
