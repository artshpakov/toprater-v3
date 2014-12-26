Rails.application.routes.draw do

  root 'index#index'
  scope "/(:locale)", locale: /en|ru/ do
    get '/' => 'index#index'
    
    scope "/(:sphere)" do
      get '/' => 'index#index', as: :sphere

      get '/objects(/criteria/:criteria)(/filters/*filters)' => 'alternatives#index', as: :list
      get '/objects/:id(-:tail)(/criteria/:criteria)(/filters/*filters)' => 'alternatives#show', constraints: { id: /[0-9]+/ }
      get '/objects/:id(/criteria/:criteria)(/filters/*filters)' => 'alternatives#show', as: :object
    end
  end

end
