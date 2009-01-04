ActionController::Routing::Routes.draw do |map|

  map.plan           '/plany/:id/plan',        :controller => 'plany', :action => 'plan'
  map.plan_dla_klasy '/plany/:id/plan/:klasa', :controller => 'plany', :action => 'plan_dla_klasy'
  map.wybierz_kom    '/plany/:id/plan/:klasa/:dzien/:godzina', :controller => 'plany', :action => 'wybierz_kom'
  map.nowa_klasa     '/grupy/nowa_klasa',     :controller => 'grupy', :action => 'nowa_klasa'
  map.nowa_grupa     '/grupy/:id/nowa_grupa', :controller => 'grupy', :action => 'nowa_grupa'
  map.przedmioty     '/grupy/:id/przedmioty', :controller => 'grupy', :action => 'przedmioty'
  map.dzienniki      '/dzienniki/plan',       :controller => 'dzienniki', :action => 'plan'

  map.resources :lekcje

  map.resources :plany

  map.resources :semestry

  map.resources :grupy

  map.resources :uczniowie

  map.resources :godziny

  map.resources :przedmioty

  map.resources :nauczyciele

  # Restful Authentication Rewrites
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.forgot_password '/forgot_password', :controller => 'passwords', :action => 'new'
  map.change_password '/change_password/:reset_code', :controller => 'passwords', :action => 'reset'
  map.open_id_complete '/opensession', :controller => "sessions", :action => "create", :requirements => { :method => :get }
  map.open_id_create '/opencreate', :controller => "users", :action => "create", :requirements => { :method => :get }

  # Restful Authentication Resources
  map.resources :users
  map.resources :passwords
  map.resource :session

  # Home Page
  map.root :controller => 'sessions', :action => 'new'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end