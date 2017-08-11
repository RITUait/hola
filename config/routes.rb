Rails.application.routes.draw do
  #devise_for :users
  #devise_for :admins
  #devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :contacts
  resources :contents
  resources :templates
  resources :dashboard
  root to: "dashboard#index"
  resources :signatures
  resources :contacts do
    collection { post :import }
  end

  get 'tags/:tag', to: 'contacts#index', as: :tag
  post 'send_email', to: "contents#send_email", as: :send_email
  get '/templates/:id', to: 'contents#index', constraints: { id: '#{selectedid}' }

  #if Rails.env.development?
   # mount LetterOpenerWeb::Engine, at: "/letter_opener"
  #end

end
