Rails.application.routes.draw do
  root to: 'calculator#main'
  get 'calculator/main'
  post 'calculator/calculate'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
