Rails.application.routes.draw do
  namespace :admins do
    get 'searches/search'
  end
  namespace :admins do
    get 'members/index'
    get 'members/show'
    get 'members/edit'
  end
  namespace :admins do
    get 'casts/new'
    get 'casts/index'
    get 'casts/show'
    get 'casts/edit'
  end
  namespace :members do
    get 'casts/new'
    get 'casts/index'
    get 'casts/show'
    get 'casts/edit'
  end
  namespace :admins do
    get 'programs/new'
    get 'programs/index'
    get 'programs/show'
    get 'programs/edit'
  end
  namespace :admins do
    get 'homes/top'
    get 'homes/analysis'
  end
  namespace :members do
    get 'contacts/new'
    get 'contacts/confirm'
    get 'contacts/thanks'
    get 'contacts/index'
  end
  namespace :members do
    get 'searches/search'
  end
  namespace :members do
    get 'reviews/show'
    get 'reviews/edit'
  end
  namespace :members do
    get 'casts/show'
  end
  namespace :members do
    get 'programs/index'
    get 'programs/show'
  end
  namespace :members do
    get 'homes/top'
    get 'homes/about'
  end
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords'
  }
  
  devise_for :members, controllers:{
    sessions: 'members/sessions',
    passwords: 'members/passwords',
    registrations: 'members/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
