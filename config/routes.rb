Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users

    root             "static_pages#home"
    get "help"    => "static_pages#help"
    get "about"   => "static_pages#about"
    get "contact" => "static_pages#contact"
    get "user/new"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
