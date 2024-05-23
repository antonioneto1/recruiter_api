# config/routes.rb
Rails.application.routes.draw do
  namespace :api do
    namespace :recruiter do
      resources :recruiters, except: [:new, :edit]
      resources :jobs
      resources :submissions, except: [:new, :edit]
    end

    namespace :public do
      resources :jobs, only: [:index, :show]
      resources :submissions, only: [:create]
    end

    post 'login', to: 'sessions#create'
  end
end
