set :user, "twerno"

# If you aren't deploying to /u/apps/#{application}
# on the target servers (which is the default),
# you can specify the actual location
# via the :deploy_to variable:

set :application, "edziennik"
#set :port, 8089
set :deploy_to, "/home/mat/twerno/rails/#{application}"

# --- mongrel
#set :mongrel_conf, "#{deploy_to}/current/config/mongrel_cluster.yml"

#namespace :deploy do
#  task :restart do
#    restart_mongrel_cluster
#  end
#end

after "deploy:update_code", :fix_script_perms

task :fix_script_perms do
  run "chmod 755 #{latest_release}/script/spin"
  run "chmod 755 #{latest_release}/script//process/spawner"

end
# --- git

set :repository,
 "git://github.com/twerno/edziennik.git"
set :scm, :git
set :branch, "master"
set :deploy_via, :export

# -- capistrano

set :use_sudo, false

role :app, "manta.univ.gda.pl"
role :web, "manta.univ.gda.pl"
role :db,  "manta.univ.gda.pl", :primary => true

set :keep_releases, "4"  # cap deploy:cleanup
