Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'home#index'

  require 'sidekiq/web'
  authenticate :user, lambda { |user| user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get 'statistics', to: 'statistics#index'
  devise_for :users
  post '/initialize_department' => 'application#initialize_department', as: :initialize_department
  get 'unauthorized' => 'application#unauthorized', as: :unauthorized

  resources :leads do
    member do
      get :claim
      get :close
      get :convert
      get :delegate
      post :delegate, as: :create_delegated, to: 'leads#create_delegated_lead'
      get :send_email_with_lead, as: :send_email_with
    end
  end

  resources :notifications do
    collection do
      post :mark_as_read
    end
    get 'general_notifications', to: 'notifications#general_notifications', on: :collection, as: :general
    get 'message_notifications', to: 'notifications#message_notifications', on: :collection, as: :message
  end

  resources :contacts do
    resources :comments
    resources :commercial_proposals, only: [:new, :create, :show] do
      get 'send_by_email', to: 'commercial_proposals#send_by_email', :as => :send_by_email
    end
  end
  post 'contacts/:id/change_status', to: 'contacts#change_status', :as => :change_status
  get 'contacts/:id/send_proposal', to: 'contacts#send_proposal', :as => :send_proposal
  get 'contacts/:id/phone_call', to: 'contacts#phone_call', :as => :phone_call

  resources :users do
    resources :messages do
      get 'commercial_proposals', on: :collection
      get 'outbound', on: :collection
      post 'send_mail', on: :collection
    end
  end
  get 'users/:id/myleads', to: 'users#user_leads', :as => :user_leads
  get 'users/:id/mycontacts', to: 'users#user_contacts', :as => :user_contacts
  get 'users/:id/departments', to: 'users#departments', :as => :user_departments
  get 'users/:id/settings', to: 'users#settings', :as => :user_settings

  # webhook from Mailgun for delivered and opened messages
  post 'messages/delivered', to: 'messages#delivered'
  post 'messages/opened', to: 'messages#opened'

  # Admin dashboard
  get 'admin' => 'admin/dashboard#index', :as => :admin
  get 'admin/users/become/:id' => 'admin/users#become', :as => :become_user

  namespace :admin do
    resources :users
    resources :departments do
      get 'memberships/edit' => 'memberships#edit', :as => :edit_memberships
      resources :memberships
    end
    get 'departments/:id/membership/:retire_membership_id' => 'departments#retire_user', :as => :retire_user
  end

end
