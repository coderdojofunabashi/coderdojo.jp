Rails.application.routes.draw do
  # For details on the DSL available within this file,
  # see http://guides.rubyonrails.org/routing.html

  root "home#show"

  # Render legal documents by using Keiyaku CSS
  # https://github.com/cognitom/keiyaku-css
  get "/docs/code_of_conduct", to: redirect('/docs/code-of-conduct')
  resources :docs, only: [:index, :show]

  resource :stats, only: %i(show)

  # Redirects
  get "/releases/2016/12/12/new-backend", to: redirect('/news/2016/12/12/new-backend')
  get "/blogs/2016/12/12/new-backend",    to: redirect('/news/2016/12/12/new-backend')

  # Issue SSL Certification
  get "/.well-known/acme-challenge/:id" => "lets_encrypt#show"

  # Sessions
  get '/logout',       to: 'sessions#destroy'
  resource :session, only: [:create, :destroy]

  # Default Scrivito routes. Adapt them to change the routing of CMS objects.
  # See the documentation of 'scrivito_route' for a detailed description.
  scrivito_route '/',              using: 'homepage'
  scrivito_route '(/)(*slug-):id', using: 'slug_id'
  scrivito_route '/*permalink',    using: 'permalink', format: false
end
