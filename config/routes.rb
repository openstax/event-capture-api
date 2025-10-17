Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    api_version(
      module: 'V0',
      path: { value: 'v0' },
      defaults: { format: :json }
    ) do

      resources :events, only: :create

      scope '/xapi' do
        resources :statements, only: :create
      end

      get :info, to: 'info#info'

      get :swagger, to: 'swagger#json'
    end
  end

  # Kill the Rails welcome page
  root to: proc { [404, {}, ["Not found."]] }
end
