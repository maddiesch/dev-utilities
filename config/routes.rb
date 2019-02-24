Jets.application.routes.draw do
  root 'utilities#index'

  get 'v1/ip',             to: 'utilities#ip'
  get 'v1/whoami',         to: 'utilities#whoami'
  get 'v1/time',           to: 'utilities#time'
  get 'v1/echo',           to: 'utilities#echo'
  get 'v1/status',         to: 'utilities#status_index'
  get 'v1/status/:status', to: 'utilities#status'

  any '*catchall', to: 'application#not_found'
end
