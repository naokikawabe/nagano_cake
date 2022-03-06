Rails.application.routes.draw do
  namespace :public do
    resources :addresses
    resources :orders
    resources :cart_items
    resource :customers
    resources :items
    post 'confirmation' => 'orders#confirmation'
    get 'thanks' => 'orders#thanks'
    get 'customers/confirmation' => 'customers#confirmation'
    patch 'customers/withdrawal' => 'customers#withdrawal'
  end

  scope module: :public do
    root to: 'homes#top'
    get 'homes/about'
  end

devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}

  namespace :admin do
    resources :orders
    resources :customers
    resources :genres
    resources :items
    get '/top' => 'homes#top'

  end

end
