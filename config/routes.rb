Rails.application.routes.draw do
  devise_for :users
  resources :authors, only: [:index, :show, :new, :create, :update, :destroy]
  resources :users, only: [:index, :show, :update]
  get '/user/bookings/show/taken/books', to: 'user_books#show_taken_books', as: 'show_taken_books'
  get '/user/bookings/show/readed/books', to: 'user_books#show_readed_books', as: 'readed_books'
  resources :bookings, only: [:index, :new, :update, :destroy]
  post '/bookings/update_bookings_statuses', to: 'bookings#update_bookings_statuses', as: 'update_bookings_statuses'
  post '/bookings/update_booking_status', to: 'bookings#update_booking_status', as: 'update_booking_status'
  resources :books, only: [:index, :show, :new, :create, :update, :destroy] do
    resources :copies, only: [:destroy]
  end
  post '/books/:book_id/copies/add_one', to: 'copies#create_unit_for_book', as: 'add_unit_book'
  post '/books/:book_id/copies/delete_last', to: 'copies#delete_last_unit_for_book', as: 'delete_unit_book'
  resources :user_books, only: [:index, :show]
  resources :user_bookings, only: [:index, :create]
  root to: 'home#index'
end
