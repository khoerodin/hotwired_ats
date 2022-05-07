Rails.application.routes.draw do
  resources :jobs
  devise_for :users,
  path: '',
  controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  },
  path_names: {
    sign_in: 'signin',
    password: 'forgot',
    confirmation: 'confirm',
    sign_up: 'signup',
    sign_out: 'signout'
  }
  get "dashboard/show"

  authenticated :user do
    root to: 'dashboard#show', as: :user_root
  end

  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :applicants, except: [:update, :destroy] do
    patch :change_stage, on: :member
    get :resume, action: :show, controller: 'resumes'
  end
end
