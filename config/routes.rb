Rails.application.routes.draw do

  root 'index#index'

  scope "/(:locale)", locale: /en|ru/ do
    get '/' => 'index#index'
    
    scope "/(:sphere)" do
      get '/' => 'alternatives#index', as: :sphere

      get '/index/:path' => 'catalog#index', as: :index

      scope :suggest, controller: :search do
        get :objects
        get '/' => :suggest
        get '/attrs/:scope' => :attributes
      end

      scope :reviews, controller: :reviews do
        post '/:id' => :create
        get '/:id' => :show
      end

      get '/search' => 'search#search', as: :search
      get '/catalog(/:path(/page:page))' => 'catalog#catalog', as: :catalog

      scope '/objects' do
        get '(/criteria/:criteria)(/filters/*filters)' => 'alternatives#index', as: :list
        get '/:id(-:tail)(/criteria/:criteria)(/filters/*filters)' => 'alternatives#show', constraints: { id: /[0-9]+/ }
        get '/:id(/criteria/:criteria)(/filters/*filters)' => 'alternatives#show', as: :object

        get '/:id/prices' => 'prices#index', as: :prices
      end
      get '/rating(/criteria/:criteria)(/filters/*filters)' => 'alternatives#index', as: :rating

      resources :medals, only: :index do
        member do
          get '(/criteria/:criteria)(/filters/*filters)' => 'medals#show', as: ''
        end
      end
    end

    namespace :landings do
      get '/similar-movies(/:id)' => :similar_movies
      get '/employers(/:id)(/criteria/:criteria)(/filters/*filters)' => :employers
      get '/gadgets' => :gadgets
      post '/gadgets' => :gadgets
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
