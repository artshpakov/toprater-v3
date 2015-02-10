Rails.application.routes.draw do

  root 'index#index'

  mount Split::Dashboard, at: 'split'

  scope "/(:locale)", locale: /en|ru/ do
    get '/' => 'index#index'
    
    scope "/(:sphere)" do
      get '/' => 'alternatives#index', as: :sphere

      scope :suggest, controller: :search do
        get :objects
        get '/:scope' => :suggest
        get '/' => :global
      end
      get '/search' => 'search#search', as: :search

      scope '/objects' do
        get '(/criteria/:criteria)(/filters/*filters)' => 'alternatives#index', as: :list
        get '/:id(-:tail)(/criteria/:criteria)(/filters/*filters)' => 'alternatives#show', constraints: { id: /[0-9]+/ }
        get '/:id(/criteria/:criteria)(/filters/*filters)' => 'alternatives#show', as: :object

        get '/:id/prices' => 'prices#index', as: :prices
      end
    end

    namespace :landings do
      get '/similar-movies(/:id)' => :similar_movies
      get '/nyt(/:id)(/criteria/:criteria)(/filters/*filters)' => :employers
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
