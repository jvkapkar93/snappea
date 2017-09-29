Rails.application.routes.draw do
  namespace 'api' do
    resources :restaurant do
      resources :menu do
        resources :tag
      end
    end
    resources :user
  end
  post 'login', to: 'authentication#login'
end
