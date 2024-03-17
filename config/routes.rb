Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tour_dates
      resources :tours
      resources :categories
      #resource :profiles # it will create all the routes for profiles like index, show, create, update, destroy
      # the index route will be like this: /api/v1/profiles

      # get 'profiles', to: 'profiles#index'
      resources :profiles, only: [:index] # GET /api/v1/profiles
      resource :profile, only: [:show, :create, :update, :destroy] # GET, POST, PATCH/PUT, DELETE /api/v1/profile


      mount_devise_token_auth_for 'User', at: 'auth'

      mount_devise_token_auth_for 'Admin', at: 'Admin_auth'
      as :admin do
        # Define routes for Admin within this block.
      end
    end
  end
end
