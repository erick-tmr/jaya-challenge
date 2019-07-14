# rubocop:disable Style/SymbolArray

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :issues, only: [:index, :show] do
      resources :events, only: [:index]
    end

    namespace :webhooks do
      post 'github_listen', to: 'github_listener#listen'
    end
  end
end

# rubocop:enable Style/SymbolArray
