Rails.application.routes.draw do
  # resources :influencers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: 'api', defaults: {format: :json} do
    namespace :v1 do
      resources :influencers
    end
  end
end
