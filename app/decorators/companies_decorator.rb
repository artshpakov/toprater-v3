class CompaniesDecorator < Draper::Decorator

  delegate_all

  def careers
    Hash[object.extra['careers']] rescue {}
  end

  def logo
    object.extra['logo_url']
  end

end
