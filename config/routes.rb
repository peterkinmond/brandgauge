Brandgauge::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users

  match '/campaigns' => "campaigns#index", :as => :user_root

  resource :landing_page, :only => [:show]

  resources :brands, :only => [:show] do
    resources :campaigns, :only => [:index, :show]
  end

  match '/about',     :to => 'pages#about'
  resources :tweets do
    get 'count', :on => :collection
  end

  match '/contact',     :to => 'pages#contact'
  root :to => 'landing_pages#show'

  match "/resque/admin/login" => redirect("/admin/login")

  #Mount resque web within our application
  authenticate :admin_user do
    mount Resque::Server, :at => "/resque"
  end
  
end
