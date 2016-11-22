Rails.application.routes.draw do
  get 'statistics', to: 'statistics#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  devise_for :users
  get '/initialize_department' => 'application#initialize_department', as: :initialize_department
  get 'unauthorized' => 'application#unauthorized', as: :unauthorized
  
  # Lead
  resources :leads
  get 'leads/:id/claim', to: 'leads#claim', :as => :claim_lead
  get 'leads/:id/close', to: 'leads#close', :as => :close_lead
  get 'leads/:id/delegate', to: 'leads#delegate', :as => :delegate_lead # send lead to another department
  post 'leads/:id/delegate', to: 'leads#create_delegated_lead', :as => :create_delegated_lead
  get 'leads/:id/send_lead_to_email', to: 'leads#send_lead_to_email', :as => :send_lead_to_email # send lead to another department
  get 'leads/:id/convert', to: 'leads#convert', :as => :convert_lead # convert lead to contact
  
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  # Contact
  resources :contacts do
    resources :comments
  end
  get 'contacts/:id/send_proposal', to: 'contacts#send_proposal', :as => :send_proposal
  get 'contacts/:id/phone_call', to: 'contacts#phone_call', :as => :phone_call
  
  # User
  resources :users
  get 'users/:id/myleads', to: 'users#user_leads', :as => :user_leads
  get 'users/:id/mycontacts', to: 'users#user_contacts', :as => :user_contacts
  get 'users/:id/departments', to: 'users#departments', :as => :user_departments
  get 'users/:id/settings', to: 'users#settings', :as => :user_settings
  
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
