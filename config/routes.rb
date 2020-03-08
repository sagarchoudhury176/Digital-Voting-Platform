Rails.application.routes.draw do
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end
  devise_for :users, :controllers => {:registrations  => "registrations"}
  root to: 'elections#index'
  get 'ledger', controller: 'pages', action: 'ledger'
  post 'ledger', controller: 'pages', action: 'ledger'
  resources :elections do
    get 'vote/:candidate_id', action: 'vote', as: 'vote'
  end
  resources :candidates
end
