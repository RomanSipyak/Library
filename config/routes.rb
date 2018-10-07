Rails.application.routes.draw do

  devise_for :users
  resources :authors
  resources :users
  resources :bookings
  resources :books do
    resources :copies
  end
  resources :user_books
  resources :user_bookings
  post '/books/:book_id/copies/add_one', to: 'copies#create_unit_for_book', as: 'add_unit_book'
  post '/books/:book_id/copies/delete_last', to: 'copies#delete_last_unit_for_book', as: 'delete_unit_book'
  post '/bookings/update_bookings_statuses', to: 'bookings#update_bookings_statuses', as: 'update_bookings_statuses'
  post '/bookings/update_booking_status', to: 'bookings#update_booking_status', as: 'update_booking_status'
  root to: 'home#index'
end
