Rails.application.routes.draw do
=begin
  get 'authors/index'
  get 'authors/new'
  get 'authors/create'
  get 'authors/update'
  get 'authors/show'
  get 'authors/destroy'
  get 'estimates/index'
  get 'estimates/new'
  get 'estimates/create'
  get 'estimates/update'
  get 'estimates/show'
  get 'estimates/destroy'
=end

  root to: 'for_user/books#index'
  devise_for :users

  resources :estimates

  namespace :api do
    post 'user_token' => 'user_token#create'
    resources :books, only: [:index]
    resources :authors, only: [:index, :show], param: :name
    resources :categories, only: [:index], param: :title
  end

  namespace :admin do
    resources :authors, only: [:index, :show, :new, :create, :update, :destroy]
    resources :users, only: [:index, :show, :update]
    resources :bookings, only: [:index, :new, :update, :destroy]
    resources :books, only: [:index, :show, :new, :create, :update, :destroy] do
      resources :units, only: [:destroy]
    end
    post '/bookings/update_bookings_statuses', to: 'bookings#update_bookings_statuses', as: 'update_bookings_statuses'
    post '/bookings/update_booking_status', to: 'bookings#update_booking_status', as: 'update_booking_status'
    post '/books/:book_id/units/add_one', to: 'units#create_unit_for_book', as: 'add_unit_book'
    post '/books/:book_id/recovery', to: 'books#recovery', as: 'recovery_book'
    # post '/books/:book_id/units/delete_last', to: 'units#delete_last_unit_for_book', as: 'delete_unit_book'
  end
  namespace :for_user do
    resources :authors, only: [:index, :show]
    resources :books, only: [:index, :show]
    resources :bookings, only: [:index, :create, :destroy]
    get '/bookings/show/taken/books', to: 'books#show_taken_books', as: 'show_taken_books'
    get '/bookings/show/readed/books', to: 'books#show_readed_books', as: 'readed_books'
  end
end
