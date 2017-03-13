Rails.application.routes.draw do

  #This code create HTTP GET routes for the index and about views

  get 'welcome/index'
  get 'welcome/about'

  #the root method allows the declaration of a default page the app loads when navigating to the home page URL
  #root is a method that takes a hash as an argument-here the implied hash syntax is used. This line could be
  #rewritten as: `root({to: 'weclome#index'})`. However, implied hashes enhance readability.
  root 'welcome#index'

end
