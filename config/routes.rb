require 'sidekiq/web'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books, only:%i[create show] do 
    collection do
      post :show_book
    end
  end
  resources :authors, only:%i[create show] do 
    collection do
      post :show_author
    end
  end
  resources :users, only:%i[create show]  do 
    collection do
      post :show_user
    end
  end
  resources :borrowers, only:%i[create show] do 
    collection do
      post :return_book
    end
  end
  resources :admins, only:%i[create] do 
    collection do
      post :sign_in
      delete :sign_out
    end
  end
  mount Sidekiq::Web, at: "/sidekiq"
end


