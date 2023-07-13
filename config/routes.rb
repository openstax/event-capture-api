Rails.application.routes.draw do
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
