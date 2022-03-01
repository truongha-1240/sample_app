Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users

    root             "static_pages#home"
    get "help"    => "static_pages#help"
    get "about"   => "static_pages#about"
    get "contact" => "static_pages#contact"
  end
end