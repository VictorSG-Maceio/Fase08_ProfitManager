Rails.application.routes.draw do
  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users
      resources :gains
      resources :expenses
      devise_for :users, controllers: { session: "api/v1/sessions" }
    end
    namespace :v2 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :gains
      resources :expenses
    end
  end

end
