Rails.application.routes.draw do
  resources :profiles
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'

      mount_devise_token_auth_for 'Admin', at: 'Admin_auth'
      as :admin do
        # Define routes for Admin within this block.
      end
    end
  end
end
