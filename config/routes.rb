# -*- encoding : utf-8 -*-
AutoCartBackend::Application.routes.draw do
  resources :notebooks do
    collection do
      get :available_notebooks
    end
  end

end
