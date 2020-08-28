Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :categories, only: :index
    resources :job_posts, only: %i(index new create)
    resources :users, only: :create, path: "signup"
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(index show destroy)
    resources :profiles, only: %i(show edit update)
    resources :job_applications, only: %i(index create update)
    resources :educations, only: %i(create update destroy)
    resources :experiences, only: %i(create update destroy)
  end
end
