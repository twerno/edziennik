ActionController::Routing::Routes.draw do |map|
  map.admin_index    '/admin/',                :controller => 'admin',    :action => 'index'
  map.archives       '/archives/index',        :controller => 'archives', :action => 'index'
  map.archives_show  '/archives/show',         :controller => 'archives', :action => 'show'
  map.archives_restore '/archives/restore',    :controller => 'archives', :action => 'restore'
  
  map.rodzic_plan    '/rodzic/plan',           :controller => 'rodzic', :action => 'plan'
  map.rodzic_oceny   '/rodzic/oceny',          :controller => 'rodzic', :action => 'oceny'
  map.rodzic_obecn   '/rodzic/obecnosci',      :controller => 'rodzic', :action => 'obecnosci'
  map.rodzic_przed   '/rodzic/przedmioty',     :controller => 'rodzic', :action => 'przedmioty'
  map.rodzic_przed2  '/rodzic/przedmiot/:id',  :controller => 'rodzic', :action => 'przedmiot'

  map.uczen_plan     '/uczen/plan',            :controller => 'uczen', :action => 'plan'
  map.uczen_oceny    '/uczen/oceny',           :controller => 'uczen', :action => 'oceny'
  map.uczen_obecn    '/uczen/obecnosci',       :controller => 'uczen', :action => 'obecnosci'
  map.uczen_przed    '/uczen/przedmioty',      :controller => 'uczen', :action => 'przedmioty'
  map.uczen_przed2   '/uczen/przedmiot/:id',   :controller => 'uczen', :action => 'przedmiot'

  map.nauczyciel_plan '/nauczyciel/plan',      :controller => 'nauczyciel',  :action => 'plan'
  map.nauczyciel_dziennik '/nauczyciel/dziennik', :controller => 'nauczyciel',  :action => 'dziennik'

  map.grupy_intro      '/grupy/intro',         :controller => 'grupy',       :action => 'intro'
  map.naucz_intro      '/nauczyciele/intro',   :controller => 'nauczyciele', :action => 'intro'
  map.rodzi_intro      '/rodzic/intro',        :controller => 'rodzic',      :action => 'intro'
  map.uczni_intro      '/uczniowie/intro',     :controller => 'uczniowie',   :action => 'intro'
  map.godzi_intro      '/godziny/intro',       :controller => 'godziny',     :action => 'intro'
  map.przed_intro      '/przedmioty/intro',    :controller => 'przedmioty',  :action => 'intro'
  map.semes_intro      '/semestry/intro',      :controller => 'semestry',    :action => 'intro'
  map.plany_intro      '/plany/intro',         :controller => 'plany',       :action => 'intro'
  map.uczen_intro      '/uczen.intro',         :controller => 'uczen',       :action => 'intro'
  map.nauczyciel_intro '/nauczyciel/intro',    :controller => 'nauczyciel',  :action => 'intro'
  map.admin_intro      '/admin/intro',         :controller => 'admin',       :action => 'intro'

 
  map.plan_update     '/plany/update/:id',         :controller => 'plany', :action => 'update'
  map.plan            '/plany/:id/plan',        :controller => 'plany', :action => 'plan'
  map.plan_dla_klasy  '/plany/:id/plan/:klasa', :controller => 'plany', :action => 'plan_dla_klasy'
  map.wybierz_kom     '/plany/:id/plan/:klasa/:dzien/:godzina.:format', :controller => 'plany', :action => 'wybierz_kom', :format => 'js'
  map.nowa_klasa      '/grupy/nowa_klasa',     :controller => 'grupy', :action => 'nowa_klasa'
  map.nowa_grupa      '/grupy/:id/nowa_grupa', :controller => 'grupy', :action => 'nowa_grupa'
  map.przedmioty_klasy '/grupa/:id/przedmioty', :controller => 'grupy', :action => 'przedmioty'
  #map.plan_dla        '/dzienniki/plan/:parametry',   :controller => 'dzienniki', :action => 'plan'
  #map.dziennik        '/dzienniki/:parametry', :controller => 'dzienniki', :action => 'show'
  #map.obecnosc        '/dzienniki/obecnosc/:parametry', :controller => 'dzienniki', :action => 'sprawdz_obecnosc', :parametry => nil
  #map.obecnosc_create '/dzienniki/obecnosc/create/:parametry', :controller => 'dzienniki', :action => 'obecnosc_create'
  map.generuj_haslo   '/uczniowie/nowe_haslo/:parametry.:format', :controller => 'hasla', :action => 'nowe_haslo'
  #map.dziennik2       '/dzienniki/p/:klasa', :controller => 'dzienniki', :action => 'show'



  # Restful Authentication Rewrites
  map.acc_edit '/edit', :controller => 'sessions', :action => 'edit'
  map.acc_edit '/update', :controller => 'sessions', :action => 'update'  
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
  map.resources :godziny
  map.resources :grupy
  map.resources :lekcje
  map.resources :nauczyciele
  map.resources :passwords
  map.resources :plany
  map.resources :przedmioty
  map.resources :semestry
  map.resource  :session
  map.resources :uczniowie
  map.resources :users

  
  # Home Page
  map.root :controller => 'sessions', :action => 'index'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action.:format'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end