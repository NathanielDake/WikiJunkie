Rails.application.routes.draw do

  resources :wikis

  devise_for :users, controllers: { sessions: 'users/sessions' }
  #This code create HTTP GET routes for the index and about views

  get 'welcome/index'
  get 'welcome/wikis'

  resources :charges, only: [:new, :create]

  post 'charges/down_grade_to_standard', to: 'charges#down_grade_to_standard'

  get 'charges/downgrade'

  #the root method allows the declaration of a default page the app loads when navigating to the home page URL
  #root is a method that takes a hash as an argument-here the implied hash syntax is used. This line could be
  #rewritten as: `root({to: 'weclome#index'})`. However, implied hashes enhance readability.
  root 'welcome#index'

end
