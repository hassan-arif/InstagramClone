Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    member do
      delete :delete_attachment
    end
  end
  resources :stories

  # get 'home/index'
  root 'home#index'
  get 'home/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
