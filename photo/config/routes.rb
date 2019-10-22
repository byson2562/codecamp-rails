Rails.application.routes.draw do
  root  'users#top'
  get   '/top',                  to:'users#top',              as: :top
  get   '/sign_up',              to:'users#sign_up',          as: :sign_up
  post  '/sign_up',              to:'users#sign_up_process',  as: :sign_up_process
  get   '/sign_in',              to:'users#sign_in',          as: :sign_in
  post  '/sign_in',              to:'users#sign_in_process',  as: :sign_in_process
  get   '/sign_out',             to:'users#sign_out',         as: :sign_out
  get   '/profile/(:id)',        to:'users#show',             as: :profile
  post  '/profile/edit',         to:'users#update',           as: :profile_edit
  get   '/follower_list/(:id)',  to:'users#follower_list',    as: :follower_list
  get   '/follow_list/(:id)',    to:'users#follow_list',      as: :follow_list
  post  '/posts',                to:'posts#create',           as: :posts
  resources :posts
end
