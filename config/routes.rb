Rails.application.routes.draw do

  root 'index#index'
  scope "/(:locale)", locale: /en|ru/ do
    get '/' => 'index#index'
    
    scope "/(:sphere)" do
      get '/' => 'index#index'

    end
  end

end
