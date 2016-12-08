Rails.application.routes.draw do
  resources :admins, :controller => "admins"
  match 'admins/:id' => 'admins#destroy', :via => [:get, :post], :as => :admin_destroy
  match 'admins/:id/edit' => 'admins#edit', :via => [:get, :post], :as => :admin_edit
  get 'welcome/index'
  root 'welcome#index'
  resources :contracts
  resources :campaigns do
    resources :groupcampaigns, only: [:create, :destroy]
  end
  resources :groups do
    resources :usergroups, only: [:create, :destroy]
  end
  resources :companies do
    resources :companycampaigns, only: [:create, :destroy]
  end
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
