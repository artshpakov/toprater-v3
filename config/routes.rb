Rails.application.routes.draw do

  root 'index#index'
  scope "/(:locale)", locale: /en|ru/ do
    get '/' => 'index#index'
    
    scope "/(:sphere)" do
      get '/' => 'index#index', as: :sphere

      scope '/objects' do
        get '(/criteria/:criteria)(/filters/*filters)' => 'alternatives#index', as: :list
        get '/:id(-:tail)(/criteria/:criteria)(/filters/*filters)' => 'alternatives#show', constraints: { id: /[0-9]+/ }
        get '/:id(/criteria/:criteria)(/filters/*filters)' => 'alternatives#show', as: :object

        get '/:id/prices' => 'prices#index', as: :prices
      end
    end

    namespace :landings do
      get '/similar/:id' => :similar
    end
  end

end
