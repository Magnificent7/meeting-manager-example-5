Rails.application.routes.draw do
  get '/' => 'meetings#index'

  resources :meetings

  namespace :api do
    namespace :v1 do
      get '/meetings' => 'meetings#index'
      post '/meetings' => 'meetings#create'
      get '/meetings/:id' => 'meetings#show'
      get '/tags' => 'tags#index'
    end
  end
end


# Prefix Verb   URI Pattern                  Controller#Action
#              GET    /                            meetings#index
#     meetings GET    /meetings(.:format)          meetings#index
#              POST   /meetings(.:format)          meetings#create
#  new_meeting GET    /meetings/new(.:format)      meetings#new
# edit_meeting GET    /meetings/:id/edit(.:format) meetings#edit
#      meeting GET    /meetings/:id(.:format)      meetings#show
#              PATCH  /meetings/:id(.:format)      meetings#update
#              PUT    /meetings/:id(.:format)      meetings#update
#              DELETE /meetings/:id(.:format)      meetings#destroy