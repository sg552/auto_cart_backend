AutoCartBackend::Application.routes.draw do
  resources :notebooks do
    collection do
      get :available_notebooks
    end
  end
  #match ':controller(/:action(/:id))(.:format)'
end
