Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root :to => redirect("index")

  namespace :api do
    namespace :restrito do
      namespace :v1 do
        namespace :auth do
          post '/login', to: 'authentication#login'
        end
        namespace :user do
          resources :users, param: :_username
        end
      end
    end
  end
    get '/*a', to: 'application#not_found'

end
