Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      passwords: 'users/passwords',
      registrations: 'users/registrations',
      confirmations: 'users/confirmations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admins
  resources :contacts
  resources :home
  resources :contents
  resources :admin_dashboard
  resources :templates
  resources :dashboard
  root to: "dashboard#index"
  resources :signatures
  resources :contacts do
    collection { post :import }
  end

  get 'tags/:tag', to: 'contacts#index', as: :tag
  post 'send_email', to: 'contents#send_email', as: :send_email
  post 'self_email', to: 'contents#self_email', as: :self_email
  get '/templates/:id', to: 'contents#index', constraints: { id: '#{selectedid}' }
  get 'user_signature', to:'home#user_signature', as: :user_signature
  post 'contact_register', to: 'home#contact', as: :contact_register

  #if Rails.env.development?
   # mount LetterOpenerWeb::Engine, at: "/letter_opener"
  #end

end
