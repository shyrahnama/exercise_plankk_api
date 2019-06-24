Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # resources :influencers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: 'api', defaults: {format: :json} do
    namespace :v1 do
      resources :influencers
      resources :influencers, only: [:show] do 
      	resources :workouts, only: [:index]
      end

      resources :workouts
    end
  end
end
