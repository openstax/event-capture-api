Rails.application.routes.draw do
  namespace :api do
    api_version(
      module: 'V0',
      path: { value: 'v1' },
      defaults: { format: :json }
    ) do

      resources :events, only: :create

      get :swagger, to: 'swagger#json'
    end
  end
end
