# -*- encoding : utf-8 -*-
AutoCartBackend::Application.routes.draw do
  resources :global_settings


  resources :notebook_filters


  resources :notebooks do
    collection do
      get :available_notebooks
    end
  end

end
