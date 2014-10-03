Acisapi::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # api vendor_string: "acis", default_version: 1, defaults: { format: 'json' }, 'ACCEPT' => 'application/vnd.acis+json'  do
  #   version 1 do
  #     cache as: 'v1' do
  #       resources :verification_codes
  #       resources :users
  #       resources :profiles
  #     end
  #   end
  # end

  api_version(:module => "v1", :header => {:name => "Accept", :value => "application/vnd.acis.json; version=1"}) do
    resources :verification_codes
    resources :users
    resources :profiles
  end
end
