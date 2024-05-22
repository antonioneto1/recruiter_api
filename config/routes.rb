Rails.application.routes.draw do
  namespace :api do
    resources :submissions
    resources :jobs
    resources :recruiters

    post '/login', to: 'sessions#create'
  end
end
