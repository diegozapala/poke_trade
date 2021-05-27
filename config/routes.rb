Rails.application.routes.draw do
  root 'home#index'

  post 'get_poke'       , to: 'pokemon#get_poke'

  get  'exchanges'      , to: 'exchange#index'
  post 'valid_exchange' , to: 'exchange#valid_exchange'
end
