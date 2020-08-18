Rails.application.routes.draw do
  get 'users/new'
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    resources :users, only: :create, path: "signup"
    resources :account_activations, only: :edit
  end
end
