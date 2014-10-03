Acisapi::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  namespace :api, defaults: { format: 'json' } do
    scope module: :v1 do
      resources :sessions, only: %w(create)
      resources :verification_codes do
        collection do
          post :check_verification
        end
      end
      resources :users do
        collection do
          get :get_user
          post :create_user
          post :deactivate_user
          post :ignore
          post :resend_verification_code
        end
      end
      resources :profiles do
        collection do
          post :create_profile
        end
      end
    end
  end
end
