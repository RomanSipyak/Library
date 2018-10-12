Rails.application.routes.draw do
  get 'user_authors/index'
  get 'user_authors/new'
  get 'user_authors/create'
  get 'user_authors/update'
  get 'user_authors/show'
  get 'user_authors/destroy'
  get 'estimates/index'
  get 'estimates/new'
  get 'estimates/create'
  get 'estimates/update'
  get 'estimates/show'
  get 'estimates/destroy'
  devise_for :users
  resources :authors, only: [:index, :show, :new, :create, :update, :destroy]
  resources :user_authors, only: [:index, :show]
  resources :users, only: [:index, :show, :update]

  get '/user/bookings/show/taken/books', to: 'user_books#show_taken_books', as: 'show_taken_books'
  get '/user/bookings/show/readed/books', to: 'user_books#show_readed_books', as: 'readed_books'
  resources :bookings, only: [:index, :new, :update, :destroy]
  post '/bookings/update_bookings_statuses', to: 'bookings#update_bookings_statuses', as: 'update_bookings_statuses'
  post '/bookings/update_booking_status', to: 'bookings#update_booking_status', as: 'update_booking_status'
  resources :books, only: [:index, :show, :new, :create, :update, :destroy] do
    resources :copies, only: [:destroy]

  end
  resources :estimates
  post '/books/:book_id/copies/add_one', to: 'copies#create_unit_for_book', as: 'add_unit_book'
  post '/books/:book_id/copies/delete_last', to: 'copies#delete_last_unit_for_book', as: 'delete_unit_book'
  resources :user_books, only: [:index, :show]
  resources :user_bookings, only: [:index, :create]
  root to: 'user_books#index'
end
