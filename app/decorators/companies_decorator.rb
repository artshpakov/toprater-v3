class CompaniesDecorator < Draper::Decorator

  delegate_all

  def careers
    Hash[object.extra['careers']]
  end

end
