Rails.application.routes.draw do

  root 'index#index'
  scope "/(:locale)", locale: /en|ru/ do
    get '/' => 'index#index'
    
    scope "/(:sphere)" do
      get '/' => 'index#index'

      resources :alternatives, path: :objects, only: %i(index show)
      get '/objects/(criteria/:criteria)(/filters/*filters)' => 'alternatives#index', as: :list
    end
  end

end
