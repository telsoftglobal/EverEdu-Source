Rails.application.routes.draw do
  resources :photos

  #router educations
  resources :educations

  #router quick update
  get 'aes_actions/quickedit'
  patch 'aes_actions/quickupdate'

  patch 'materials/quickupdate'
  get 'materials/quickedit'

  patch 'curriculums/quickupdatecategories'
  get 'curriculums/quickeditcategories'

  patch 'curriculums/quickupdate'
  get 'curriculums/quickedit'

  #router for work experience
  get 'work_experiences/update_levels'
  resources :work_experiences

  #router for aes-actions
  #resources :aes_actions
  match 'actions/:id', to: 'aes_actions#show', via: [:get],  as: 'aes_action_show'
  #router for materials
  resources :materials
  #router for users
  get 'users/about'
  match 'about/:id', to: 'users#about', via: [:get],  as: 'about'

  get 'users/show_user_profile'
  match 'update_user_profile', :to => 'users#update_user_profile', :via => [:get, :patch]

  match 'user/change_avatar', to: 'users#change_avatar', via: [:post],  as: 'change_avatar'
  get 'users/show'
  post 'users/send_mail'

  match 'forgot', :to => 'sessions#forgot', :via => [:get, :post], :as => 'forgot'

  post 'users/resetpassword'
  get 'users/changepassword'
  post 'users/changepassword'

  resources :users

  #router for comments
  get 'roadmap/get_more_roadmap'
  get 'roadmap/index'
  post 'roadmap/create'
  post 'roadmap/delete'
  post 'roadmap/update'
  get 'roadmap/update_levels'

  get '/comments/get_more_comments'
  get 'comments/index'


  get 'comments/new'

  get 'comments/create'
  post 'comments/create'

  get 'comments/reply'
  post 'comments/reply'


  #router for comment


  get 'comment/update'

  get 'comment/destroy'
  #end router for comment

  get 'home/error'

  #route for curriculm
  get 'curriculums/get_material_types'
  get 'curriculums/update_content'
  get 'curriculums/getlevel'
  resources :aes_actions
  resources :materials
  resources :curriculums
  match 'curriculums/join/:id', to: 'curriculums#join', via: [:get],  as: 'join_curriculum'
  match 'curriculums/comment/:id', to: 'curriculums#comment', via: [:get],  as: 'comments_curriculum'
  match 'curriculums/materials/:id', to: 'curriculums#materials', via: [:get],  as: 'materials_curriculum'
  match 'curriculums/actions/:id', to: 'curriculums#actions', via: [:get],  as: 'actions_curriculum'
  # match 'curriculums/studentdetail/:id', to: 'curriculums#show_for_student', via: [:get],  as: 'show_curriculum_for_student'
  match 'curriculums/mentordetail/:id', to: 'curriculums#show_for_mentor', via: [:get],  as: 'show_curriculum_for_mentor'

 #Student
  get 'student/update_curriculum_detail', as: 'update_curriculum_detail'
  get 'student/update_menu_right', as: 'update_menu_right'
  match 'student/curriculum-detail/:id', to: 'student#show', via: [:get],  as: 'show_curriculum_detail_for_student'

  #mentor
  get 'mentor/update_curriculum_detail', as: 'mentor_update_curriculum_detail'
  match 'mentor/curriculum-detail/:id', to: 'mentor#show', via: [:get],  as: 'show_curriculum_detail_for_mentor'


  get 'home/index'

  get 'mentor/index'
  get 'student/index'
  get 'mentor/create'

  #route for search curriculum
  get 'search/index'
  get 'search/search_curriculum'
  get 'search/update_levels', as: 'update_levels'
  match 'search-curriculum', :to => 'search#search_curriculum', :via => [:get], :as => 'search-curriculum'

  #route for session
  match 'signup', :to => 'sessions#signup', :via => [:get, :post], :as => 'signup'
  match 'signin', :to => 'sessions#signin', :via => [:get, :post], :as => 'signin'
  match 'signout', :to => 'sessions#signout', :via => [:get, :post], :as => 'signout'
  match 'welcome', :to => 'home#welcome', :via =>[:get], :as => 'welcome'
  match 'about-us', :to => 'home#about_us', :via =>[:get], :as => 'about_us'
  match 'home', :to => 'home#index', :via => [:get], :as => 'home'

  match 'become_mentor', :to => 'student#become_mentor', :via => [:get, :post], :as => 'become_mentor'



  get 'sessions/signin'

  get 'sessions/signup'

  get 'sessions/signout'



  root 'sessions#signin'

  get '/auth/:provider/callback', to: 'sns_sessions#create'
  get '/auth/failure', to: redirect('/')
  get 'sns_sessions/create'

  match 'signup_sns', :to => 'sns_sessions#signup_sns', :via => [:get, :post], :as => 'signup_sns'
  get 'sns_sessions/signup_sns'

  get 'sns_sessions/signin_sns'

  match '/404', to: 'home#file_not_found', via: :all
  match '/422', to: 'home#unprocessable', via: :all
  match '/500', to: 'home#internal_server_error', via: :all

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comment, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comment
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
