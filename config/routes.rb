# config/routes.rb
Rails.application.routes.draw do
  devise_for :recruiters
  namespace :api do
    namespace :recruiter_api do
      resources :recruiters, except: [:new, :edit]
      resources :jobs
      resources :submissions, except: [:new, :edit]
    end

    namespace :public do
      resources :jobs, only: [:index, :show]
      resources :submissions, only: [:create, :show]
    end

    post 'login', to: 'sessions#sign_user'
  end
end
