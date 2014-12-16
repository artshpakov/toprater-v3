Rails.application.routes.draw do

  root 'index#index'
  scope "/(:locale)", locale: /en|ru/ do
    get '/' => 'index#index'
    
    scope "/(:sphere)" do
      get '/' => 'index#index', as: :sphere

      get '/objects(/criteria/:criteria)(/filters/*filters)'      => 'alternatives#index',  as: :list
      get '/objects/:id(/criteria/:criteria)(/filters/*filters)'  => 'alternatives#show',   as: :object
    end
  end

end
