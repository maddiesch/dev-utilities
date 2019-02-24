Jets.application.routes.draw do
  root 'utilities#index'

  get 'v1/ip',     to: 'utilities#ip'
  get 'v1/whoami', to: 'utilities#whoami'
  get 'v1/time',   to: 'utilities#time'

  any '*catchall', to: 'application#not_found'
end
