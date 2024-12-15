# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :lounge_owners, path: '', path_names:
    {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
                             controllers: { sessions: 'lounge_owners/sessions', registrations: 'lounge_owners/registrations' }

  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'lounge_owners/current_lounge_owner', to: 'lounge_owners/current_lounge_owner#show'
  resources :lounges
end
