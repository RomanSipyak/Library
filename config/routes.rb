Rails.application.routes.draw do
  devise_for :users
  resources :authors, %i[index show new create update destroy]
  resources :users, %i[index show]
  get '/user/bookings/show/taken/books', to: 'user_books#show_taken_books', as: 'show_taken_books'
  get '/user/bookings/show/readed/books', to: 'user_books#show_readed_books', as: 'readed_books'
  resources :bookings, %i[index new update destroy]
  post '/bookings/update_bookings_statuses', to: 'bookings#update_bookings_statuses', as: 'update_bookings_statuses'
  post '/bookings/update_booking_status', to: 'bookings#update_booking_status', as: 'update_booking_status'
  resources :books, %i[index show new create update destroy] do
    resources :copies, %i[destroy]
  end
  post '/books/:book_id/copies/add_one', to: 'copies#create_unit_for_book', as: 'add_unit_book'
  post '/books/:book_id/copies/delete_last', to: 'copies#delete_last_unit_for_book', as: 'delete_unit_book'
  resources :user_books, %i[index show]
  resources :user_bookings, %i[index,create]
  root to: 'home#index'
end
