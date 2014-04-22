# -*- Mode: Ruby; Ruby-indent-level: 2; Indent-tabs-mode: nil -*-
Leaguer::Application.routes.draw do

  resources :brackets

  resources :sessions, only: [:new, :create, :destroy]

  resources :users

  resources :games

  resources :pms

  resources :alerts

  resource :server, only: [:show, :edit, :update]

  #match 'simple_captcha/:id', :to => 'simple_captcha#show', :as => :simple_captcha

  resources :teams

  resources :tournaments do
    resources :matches, only: [:index, :show, :update]
  end

  root to: 'static#homepage'

  get '/testsvg', to: 'static#test'

  get '/search', to: 'search#go'

end


Leaguer::Application.routes.named_routes.module.module_eval do
  def match_path(match, options={})
    tournament_match_path(match.tournament_stage.tournament, match, options)
    end
  def match_url(match, options={})
    tournament_match_url(match.tournament_stage.tournament, match, options)
  end
end

if false
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
