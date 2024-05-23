Rails.application.routes.draw do
  namespace :api do
    resources :submissions, except: [:new, :edit]
    resources :jobs, except: [:new, :edit]
    resources :recruiters, except: [:new, :edit]

    post 'login', to: 'sessions#create'
  end
end
