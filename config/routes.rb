require "sidekiq/web"
Rails.application.routes.draw do
  
  get 'uploads/index', :as => :uploads
  post 'uploads/create_data'
  resources :admins, :controller => "admins"
  match 'admins/:id' => 'admins#destroy', :via => [:get, :post], :as => :admin_destroy
  match 'admins/:id/edit' => 'admins#edit', :via => [:get, :post], :as => :admin_edit
  get 'welcome/index'
  root 'welcome#index'
  resources :contacts, except: [:create, :new] do
    resources :historycontacts, only: [:create]
    match "/historycontacts/:id" => "historycontacts#download", :via => [:post], :as => :download_attachment
    resources :contracts
    match "/contracts/:id" => "contracts#download", :via => [:post], :as => :download_contract
  end
  resources :campaigns do
    resources :groupcampaigns, only: [:create, :destroy]
  end
  resources :groups do
    resources :usergroups, only: [:create, :destroy]
  end
  resources :notifications, only: [:index, :update]
  resources :companies do
    resources :usercompanies, only: [:create, :destroy]
    resources :templates do
      resources :datatemplates
    end
    resources :companycampaigns, only: [:create, :destroy]
  end
  devise_for :users


  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
