Rails.application.routes.draw do
  get 'play/game'
  get 'game', to: 'play#game'

  get 'play/score'
  get 'score', to: 'play#score'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
