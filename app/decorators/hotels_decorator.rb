class HotelsDecorator < Draper::Decorator

  delegate_all

  def full_address
    address['full_address']
  end

  def stars
    object.extra['stars'].to_i.floor
  end

  def price
    extra['price']
  end

end
