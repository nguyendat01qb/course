Rails.application.routes.draw do
  scope '(:locale)', locale: /en|ja/ do
    get 'my_course/index'
    ActiveAdmin.routes(self)
    root 'static_pages#home'
    get 'static_pages/home'
    resources :categories, only: [:index, :show]
    resources :courses
    resources :my_courses, only: [:index]
    resources :carts, only: [:index]

    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :courses, only: [:index] do
          collection do
            delete :destroy
          end
        end
        resources :carts, only: [:create] do
          collection do
            delete :destroy
          end
        end
        resources :orders, only: [:index, :create]
        resources :reviews, only: [:index, :create] do
          collection do
            delete :destroy
          end
        end
      end
    end
    # resources :events
    # resources :contacts
    # resources :topics

    devise_for :users
    match "/images/uploads/*path" => "gridfs#serve", via: [:get, :post]
  end
end
