Rails.application.routes.draw do

  devise_for :users
  resources :authors
  resources :users
  resources :books do
    resources :copies
  end
  post '/books/:book_id/copies/add_one', to: 'copies#create_unit_for_book', as: 'add_unit_book'
  post '/books/:book_id/copies/delete_last', to: 'copies#delete_last_unit_for_book', as: 'delete_unit_book'
  root to: 'home#index'
end
