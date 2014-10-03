Acisapi::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  api vendor_string: "acis", default_version: 1 do
    version 1 do
      cache as: 'v1' do
        #post 'twilio/voice' => 'twilio#voice'
        resources :verification_codes
      end
    end
  end
end
