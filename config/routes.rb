Rails.application.routes.draw do

  root 'index#index'

  scope "/(:locale)", locale: /en|ru/ do
    get '/' => 'index#index'
    
    scope "/(:sphere)" do
      get '/' => 'index#index', as: :sphere
      get '/suggest/objects' => 'suggest#objects'
      get '/suggest/:scope' => 'suggest#suggest'
      get '/suggest' => 'suggest#global'

      scope '/objects' do
        get '(/criteria/:criteria)(/filters/*filters)' => 'alternatives#index', as: :list
        get '/:id(-:tail)(/criteria/:criteria)(/filters/*filters)' => 'alternatives#show', constraints: { id: /[0-9]+/ }
        get '/:id(/criteria/:criteria)(/filters/*filters)' => 'alternatives#show', as: :object

        get '/:id/prices' => 'prices#index', as: :prices
      end

      get '/search' => 'landings#search', as: :search
    end

    namespace :landings do
      get '/similar-movies(/:id)' => :similar_movies
    end
  end

  namespace :auth do
    post :signin, :signup, :signout
    post :forgot_password
    get  :edit_password
    post '/change_password/:token' => :change_password, as: :change_password
    get "/:provider/callback" => :callback
  end

end
