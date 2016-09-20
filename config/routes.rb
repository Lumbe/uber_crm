Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { sessions: 'users/sessions', confirmations: 'users/confirmations', passwords: 'users/passwords', registrations: 'users/registrations', unlocks: 'users/unlocks' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :leads
  get 'leads/:id/convert', to: 'leads#convert', :as => :convert_lead
  resources :contacts
  resources :users
  get 'users/:id/departments', to: 'users#departments', :as => :user_departments
  get 'users/:id/profile', to: 'users#profile', :as => :user_profile
  get 'users/:id/settings', to: 'users#settings', :as => :user_settings

  get 'admin' => 'admin/dashboard#index', :as => :admin
  # sign_in as user
  get 'admin/users/become/:id' => 'admin/users#become', :as => :become_user
  
  namespace :admin do
    resources :users
    resources :departments do
      get 'memberships/edit' => 'memberships#edit', :as => :edit_memberships
      resources :memberships
    end
    get 'departments/:id/membership/:retire_membership_id' => 'departments#retire_user', :as => :retire_user
  end
  
  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
