Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :api do
    namespace :v1 do
      resources :tasks, except: [:show]
      resources :tags, except: [:show]
    end
  end

end
