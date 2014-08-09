# -*- encoding : utf-8 -*-
require 'capistrano-rbenv'
load 'deploy/assets'
set :rake, "bundle exec rake"

set :application, "auto_cart_backend"
set :repository, "git@github.com:sg552/auto_cart_backend.git"
set :scm, :git

#set :repository, "."
#set :scm, :none
#set :deploy_via, :copy

server = 'siwei.me'

role :web, server
role :app, server
role :db,  server, :primary => true
role :db,  server

set :deploy_to, "/opt/app/siwei/auto_cart_backend"
default_run_options[:pty] = true

set :user, "root"

namespace :deploy do
  task :start do
    run "cd #{release_path} && bundle exec thin start -C config/thin.yml"
  end
  task :stop do
    run "cd #{release_path} && bundle exec thin stop -C config/thin.yml"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    db_migrate
    stop
    sleep 2
    start
  end
  task :db_migrate do
    run "cd #{release_path} && bundle install --local --without=development test"
    run "cd #{release_path} && bundle exec rake db:migrate RAILS_ENV=production"
  end

  namespace :assets do
    task :precompile do
      #run "bundle install"
      #run "cd #{release_path} && bundle exec rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile "
    end
  end
end


desc "Copy database.yml to release_path"
task :cp_database_yml do
  puts "=== executing my customized command: "
  run "cp -r #{shared_path}/config/* #{release_path}/config/"
  run "chmod -R 777 #{release_path}"
  puts "=== done (executing my customized command)"
end

before "deploy:assets:precompile", :cp_database_yml
#after "deploy", "deploy:restart"
