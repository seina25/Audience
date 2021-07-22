Rails.application.routes.draw do

  # ==== 会員側 =================================================================

  devise_for :members, controllers:{
    sessions: 'members/sessions',
    passwords: 'members/passwords',
    registrations: 'members/registrations'
  }

  scope module: :members do
    root 'homes#top'
    get 'about' => 'homes#about', as: :about
    get 'my_page/edit' => 'members#edit', as: :my_page_edit
    get 'my_page' => 'members#show', as: :my_page
    get 'line' => 'members#line', as: :line
    resource :member, only: [:update]
    get 'unsubscribe' => 'members#unsubscribe', as: :unsubscribe
    patch 'withdraw' => 'members#withdraw', as: :withdraw
    post 'line_events/client' => 'line_events#client', as: :client
    post 'line_events/recieve' => 'line_events#recieve', as: :recieve
    # ↓url直打ちでルートエラーになる（postをgetに変更した解消される状態）
    post 'line_events/about' => 'line_events#about'
    resources :programs, only: [:index, :show] do
      resource :favorite, only: [:create, :destroy]
      resources :reviews, only: [:create, :edit, :update, :destroy]
      collection do
      get 'search'
      end
    end
    resources :contacts, only: [:new, :index, :create]
    post 'contacts/confirm' => 'contacts#confirm'
    post 'contacts/back'=> 'contacts#back'
    get 'contacts/thanks' => 'contacts#thanks'
  end
  resources :program_notifications, only: [:index]

  # ============================================================================

  # ==== 管理者側 ==============================================================

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords'
  }

  namespace :admins do
    root 'homes#top'
    get 'analysis' => 'homes#analysis', as: :analysis
    get 'programs/scrape' => 'programs#scrape', as: :scrape
    resources :programs, only: [:index, :new, :create, :edit, :update, :show, :destroy]
    resources :members, only: [:index, :show, :edit, :update]
    get 'search' => 'searches#search', as: :search
    resources :contacts, only: [:index, :show]
  end

   # ===========================================================================


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
