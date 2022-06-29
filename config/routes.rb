Rails.application.routes.draw do
  scope '(:locale)', locale: /en|ja/ do
    get 'my_course/index'
    ActiveAdmin.routes(self)
    root 'static_pages#home'
    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :courses, only: [:index] do
          collection do
            delete :destroy
          end
        end
        resources :reviews, only: [:index, :create] do
          collection do
            delete :destroy
          end
        end
      end
    end
    resources :categories, only: [:index, :show] do
      resources :courses, only: [:index, :create, :update, :destroy]
    end
    resources :events
    resources :contacts
    resources :courses
    resources :my_courses, only: [:index]
    resources :topics
    get 'static_pages/home'
    get 'static_pages/help'
    get 'static_pages/users'

    get 'course/:slug', to: 'course_details#index'
    devise_for :users
    match "/images/uploads/*path" => "gridfs#serve", via: [:get, :post]
  end
end
