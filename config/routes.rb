Rails.application.routes.draw do
  resources :my_blogs
  scope '(:locale)', locale: /en|ja/ do
    get 'my_course/index'
    ActiveAdmin.routes(self)
    root 'static_pages#home'
    get 'static_pages/home'
    resources :categories, only: %i[index show]
    resources :courses
    resources :my_courses, only: [:index]
    resources :carts, only: [:index]
    resources :my_blogs

    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :courses, only: [:index] do
          collection do
            delete :destroy
            post :course_item
          end
        end
        resources :carts, only: %i[index create] do
          collection do
            delete :destroy
          end
        end
        resources :orders, only: [:create]
        resources :reviews, only: %i[index create] do
          collection do
            delete :destroy
          end
        end
        resources :blogs, only: %i[index] do
          collection do
            delete :destroy
          end
        end
        resources :events, only: %i[index] do
          collection do
            delete :destroy
          end
        end
      end
    end
    resources :events
    # resources :contacts
    # resources :topics

    devise_for :users
    match '/images/uploads/*path' => 'gridfs#serve', via: %i[get post]
  end
end
