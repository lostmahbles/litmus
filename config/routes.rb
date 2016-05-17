Rails.application.routes.draw do
  root to: "status_updates#index"
  
  namespace :api do
    namespace :v1 do
      scope :status do
        post '/', to: 'status#create'
      end
    end
  end
end
