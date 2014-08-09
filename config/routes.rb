# -*- encoding : utf-8 -*-
AutoCartBackend::Application.routes.draw do

  root :to => 'notebook_filters#index'
  resources :global_settings do
    collection do
      put :update_global_config
    end
  end
  resources :notebook_filters do
    collection do
      post :read_complete_content
    end
  end
  resources :notebooks do
    collection do
      get :available_notebooks
    end
  end

end
