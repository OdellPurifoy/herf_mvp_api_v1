Rails.application.routes.draw do
  devise_for :lounge_owners, path: '', path_names:
    {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
                             controllers: { sessions: 'lounge_owners/sessions', registrations: 'lounge_owners/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'lounge_owners/current_lounge_owner', to: 'lounge_owners/current_lounge_owner#show'

  # Defines the root path route ("/")
  # root "posts#index"
end
