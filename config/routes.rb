require 'sidekiq/web'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books, only:%i[create show index update destroy] 
  resources :authors, only:%i[create show update index destroy]
  resources :refer_users, only:%i[create] 
  resources :users, only:%i[index show create destroy]  do 
    collection do
      post :sign_in
      get :sign_out
    end
  end
  resources :borrower_details, only:%i[create index update show] 
  resources :admins, only:%i[create] do 
    collection do
      post :sign_in
      get :sign_out
    end
  end
  mount Sidekiq::Web, at: "/sidekiq"
end