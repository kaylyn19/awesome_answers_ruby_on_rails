Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'users/current'
    end
  end
  get 'likes/create'
  get 'likes/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # This defines a route rule that says when we receive
  # a GET request with the URL '/', handle it with the
  # WelcomeController with the index action inside that
  # controller.
  get('/', {to: 'welcome#index', as: 'root'})

  # route to contacts/new; to contact controller and new action
  get '/contacts/new', to: 'contacts#new'
  post '/contacts', {to: 'contacts#create'}
  # rails g controller questions
  # get '/questions/new', {to: 'questions#new', as:  :new_question} # creates an alias
  # # when someone requests /questions/new it will be handled by the NEW method inside of questions controller
  # post 'questions', {to: 'questions#create', as: :questions}

  # get '/questions/:id', {to: 'questions#show', as: :question} 
  # get 'questions', {to: 'questions#index', as: :index}
  # get '/questions/:id/edit', {to: 'questions#edit', as: :edit_question}

  # # handles submission of form on the question edit page
  # patch '/questions/:id', {to: 'questions#update'}

  # delete '/questions/:id', {to: 'questions#destroy'}

  # 'resources' method will generate all CRUD routes following RESTful conventions for a resource.
  # It will assume there is a controller named after the first argument, pluralized and PascalCased
  resources :questions do # nesting inside question to be able to reference questions
    # Routes written inside of a block passed to a resources method will be -pre-fixed by a path corresponding to the passed in symbol
    # In this case, all nested routes will be pre-fixed with '/questions/:question_id'
    resources :answers, only: [:create, :destroy]
    # equivalent to:
    # resources :answers, except: [:show, :index, :new, :edit, :update]
    # question_answers_path(<question-id>), question_answer_url(<question-id>)
    # question_answers_path(@question.id)
    resources :likes, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :show]

  # resources :sessions, only: [:new, :create, :destroy]

  resource :session, only: [:new, :create, :destroy]
  # 'resource' is singluar instead of 'resources'
  # unlike 'resources', 'resource' will create routes that do CRUD operation on only one thing.
  # there will be no index routes, and no route will have an ':id' wild card. 
  # When using a singluar resource, the controller must still be plural.

  resources :job_posts, only: [:new, :create, :show, :destroy, :index]


  # setting up routes for an api
  # The option 'deafults: {format: :json}' will set json as the default response for all routes contained within the block of the namespace
  # so that we don't have to pass .json in url

  # The namespace method in Rails routes makes it so it will automatically look in a directory api, then in a sub directory v1 for QuestionsController
  namespace :api, defaults: { format: :json} do 
    # /api...
    namespace :v1 do
      # /api/v1...
      resources :questions
      # /api/v1/questions
      resource :session, only: [:create, :destroy]
      # /api/v1/user
      resources :users, only: [:create] do
        # api/v1/users/current
        get :current, on: :collection
        # option collection makes the path neater
        # default: api/v1/users/:id/current
      end
    end
  end

  get "/auth/github", as: :sign_in_with_github
  get "auth/:provider/callback", to: "callbacks#index"

  ##############################
  match("/delayed_job",
  to: DelayedJobWeb, 
  anchor: false, 
  via: [:get, :post]
  )

end