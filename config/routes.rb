Acisapi::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  namespace :api, defaults: { format: 'json' } do
    scope module: :v1 do
      resources :sessions
      resources :verification_codes do
        collection do
          post :check_verification
        end
      end
      resources :users do
        collection do
          get :get_user
          post :create_user
        end
      end
      resources :profiles
    end
  end
end
