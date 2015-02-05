class HintsDecorator < Draper::Decorator
  delegate_all

  def as_json(options)
    { element: element, intro: intro, position: position }.as_json(options)
  end

  def element
    object['place']
  end

  def intro
    object['text']
  end

  def position
    object['side']
  end
end
